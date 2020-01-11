# frozen_string_literal: true

module Github
  class CheckRunService
    SLICE_COUNT = 48
    attr_reader :report, :github_data, :report_adapter, :check_name, :results

    def initialize(report: nil, github_data: nil, report_adapter: nil, check_name: nil)
      @report = report
      @github_data = github_data
      @report_adapter = report_adapter
      @check_name = check_name
    end

    def run
      id, started_at = create_check
      @results = report.build
      update_check(id, started_at)
      complete_check(id, started_at)
    end

    private

    def create_check
      check = client.send_request(
        url: endpoint_url,
        method: "post",
        body: create_check_payload
      )
      puts "Check run created with id: #{check['id']}."
      [check["id"], check["started_at"]]
    end

    def update_check(id, started_at)
      annotations.each_slice(SLICE_COUNT) do |annotations_slice|
        client.send_request(
          url: "#{endpoint_url}/#{id}",
          method: "patch",
          body: update_check_payload(annotations_slice, started_at)
        )
        puts "Updated check run with #{annotations_slice.count} annotations."
      end
    end

    def complete_check(id, started_at)
      request = client.send_request(
        url: "#{endpoint_url}/#{id}",
        method: "patch",
        body: completed_check_payload(started_at)
      )
      puts "Completed check run."
      request
    end

    def client
      @client ||= Github::Client.new(github_data.token, user_agent: "rubocop-linter-action")
    end

    def summary
      report_adapter.summary(results)
    end

    def annotations
      report_adapter.annotations(results)
    end

    def conclusion
      report_adapter.conclusion(results)
    end

    def endpoint_url
      "/repos/#{github_data.owner}/#{github_data.repo}/check-runs"
    end

    def base_payload(status)
      {
        name: check_name,
        head_sha: github_data.sha,
        status: status
      }
    end

    def create_check_payload
      base_payload("in_progress")
    end

    def completed_check_payload(started_at)
      base_payload("completed").merge!(
        conclusion: conclusion,
        started_at: started_at,
        completed_at: Time.now.iso8601
      )
    end

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
