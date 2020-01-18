# typed: strict

module Github
  class CheckRunService
    extend T::Sig

    SLICE_COUNT = 48

    # sig { returns(T.nilable(String)) }
    sig { returns(Github::Data) }
    attr_accessor :github_data
    sig { returns(ReportAdapter) }
    attr_accessor :report_adapter
    sig { returns(T::Hash[String, String]) }
    attr_accessor :results
    sig { returns(String) }
    attr_accessor :check_name

    sig { params(results: T::Hash[String, String], github_data: Github::Data, check_name: String).void }
    def initialize(results:, github_data:, check_name:)
      @github_data = github_data
      @report_adapter = ReportAdapter
      @check_name = check_name
      @results = results
    end

    sig { returns(T.untyped) }
    def run
      id, started_at = create_check
      return unless id && started_at

      update_check(id, started_at)
      complete_check(id, started_at)
    end

    private

    sig { returns(T::Array[T.nilable(String)]) }
    def create_check
      check = client.send_request(
        url: endpoint_url,
        method: "post",
        body: create_check_payload
      )
      puts "Check run created with id: #{check['id']}."
      [check["id"], check["started_at"]]
    end

    sig { params(id: String, started_at: String).returns(T::Boolean) }
    def update_check(id, started_at)
      annotations.each_slice(SLICE_COUNT) do |annotations_slice|
        client.send_request(
          url: "#{endpoint_url}/#{id}",
          method: "patch",
          body: update_check_payload(annotations_slice, started_at)
        )
        puts "Updated check run with #{annotations_slice.count} annotations."
      end
      true
    end

    sig { params(id: String, started_at: String).returns(T::Boolean) }
    def complete_check(id, started_at)
      client.send_request(
        url: "#{endpoint_url}/#{id}",
        method: "patch",
        body: completed_check_payload(started_at)
      )
      puts "Completed check run."
      true
    end

    sig { returns(Github::Client) }
    def client
      @client ||= Github::Client.new(github_data.token, user_agent: "rubocop-linter-action")
    end

    sig { returns(String) }
    def summary
      report_adapter.summary(results)
    end

    sig { returns(T::Array[T::Hash[String, String]]) }
    def annotations
      report_adapter.annotations(results)
    end

    sig { returns(T.untyped) }
    def conclusion
      report_adapter.conclusion(results)
    end

    sig { returns(T.untyped) }
    def endpoint_url
      "/repos/#{github_data.owner}/#{github_data.repo}/check-runs"
    end

    sig { params(status: T.untyped).returns(T.untyped) }
    def base_payload(status)
      {
        name: check_name,
        head_sha: github_data.sha,
        status: status
      }
    end

    sig { returns(T.untyped) }
    def create_check_payload
      base_payload("in_progress")
    end

    sig { params(started_at: T.untyped).returns(T.untyped) }
    def completed_check_payload(started_at)
      base_payload("completed").merge!(
        conclusion: conclusion,
        started_at: started_at,
        completed_at: Time.now.iso8601
      )
    end

    sig { params(annotations: T.untyped, started_at: T.untyped).returns(T.untyped) }
    def update_check_payload(annotations, started_at)
      base_payload("in_progress").merge!(
        started_at: started_at,
        output: {
          title: check_name,
          summary: summary,
          annotations: annotations
        }
      )
    end
  end
end
