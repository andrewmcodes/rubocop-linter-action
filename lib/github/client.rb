# frozen_string_literal: true

module Github
  class Client
    attr_reader :github_token, :user_agent

    def initialize(github_token, user_agent: "ruby")
      @github_token = github_token
      @user_agent = user_agent
    end

    def send_request(url: "", method: "patch", body: {}, cancel_request: false)
      response = request_http { |http|
        if method == "patch"
          http.patch(url, body.to_json, headers)
        else
          http.post(url, body.to_json, headers)
        end
      }
      # Raise if this a request to cancel the check run to prevent a potential infinite loop
      raise "#{response.code}: #{response.message}: #{response.body}" if cancel_request

      message_handler(response: response, url: url)
    end

    private

    def headers
      @headers ||= {
        "Content-Type": "application/json",
        "Accept": "application/vnd.github.antiope-preview+json",
        "Authorization": "Bearer #{github_token}",
        "User-Agent": user_agent
      }
    end

    def request_http
      http = Net::HTTP.new("api.github.com", 443)
      http.use_ssl = true
      yield(http)
    end

    def message_handler(response: {}, url: nil)
      body = JSON.parse(response.body)
      # Patch requests should return 200, Post request should return 200
      # See: https://developer.github.com/v3/checks/runs/
      return body if (response.code.to_i == 200) || (response.code.to_i == 201)

      # If request response code is not 200 || 201, send a request to cancel the check run suite.
      # See: https://bit.ly/2QLoFKx
      send_request(
        url: "#{url}/#{body["id"]}",
        body: cancel_suite_payload(body["name"], body["head_sha"]),
        cancel_request: true
      )
    end

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
