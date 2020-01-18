# typed: strict

module Github
  class Client
    extend T::Sig

    sig { returns(T.untyped) }
    attr_reader :github_token, :user_agent

    sig { params(github_token: T.untyped, user_agent: T.untyped).returns(T.untyped) }
    def initialize(github_token, user_agent: "ruby")
      @github_token = github_token
      @user_agent = user_agent
    end

    sig { params(url: T.untyped, method: T.untyped, body: T.untyped, cancel_request: T.untyped).returns(T.untyped) }
    def send_request(url: "", method: "patch", body: {}, cancel_request: false)
      response = request_http do |http|
        if method == "patch"
          http.patch(url, body.to_json, headers)
        else
          http.post(url, body.to_json, headers)
        end
      end
      # Raise if this a request to cancel the check run to prevent a potential infinite loop
      raise "#{response.code}: #{response.message}: #{response.body}" if cancel_request

      message_handler(response: response, url: url)
    end

    private

    sig { returns(T.untyped) }
    def headers
      @headers ||= {
        "Content-Type": "application/json",
        "Accept": "application/vnd.github.antiope-preview+json",
        "Authorization": "Bearer #{github_token}",
        "User-Agent": user_agent
      }
    end

    sig { returns(T.untyped) }
    def request_http
      http = Net::HTTP.new("api.github.com", 443)
      http.use_ssl = true
      yield(http)
    end

    sig { params(response: T.untyped, url: T.untyped).returns(T.untyped) }
    def message_handler(response: {}, url: nil)
      body = JSON.parse(response.body)
      # Patch requests should return 200, Post request should return 200
      # See: https://developer.github.com/v3/checks/runs/
      return body if (response.code.to_i == 200) || (response.code.to_i == 201)

      # If request response code is not 200 || 201, send a request to cancel the check run suite.
      # See: https://bit.ly/2QLoFKx
      send_request(
        url: "#{url}/#{body['id']}",
        body: cancel_suite_payload(body["name"], body["head_sha"]),
        cancel_request: true
      )
    end

    sig { params(name: T.untyped, head_sha: T.untyped).returns(T.untyped) }
    def cancel_suite_payload(name, head_sha)
      {
        name: name,
        head_sha: head_sha,
        status: "completed",
        conclusion: "failure",
        completed_at: Time.now.iso8601
      }
    end
  end
end
