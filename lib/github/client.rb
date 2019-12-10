# frozen_string_literal: true

module Github
  class Client
    attr_reader :github_token, :user_agent

    def initialize(github_token, user_agent: 'ruby')
      @github_token = github_token
      @user_agent = user_agent
    end

    def patch(url, body = {})
      request_http do |http|
        http.patch(url, body.to_json, headers)
      end
    end

    def post(url, body = {})
      request_http do |http|
        http.post(url, body.to_json, headers)
      end
    end

    private

    def headers
      @headers ||= {
        "Content-Type": 'application/json',
        "Accept": 'application/vnd.github.antiope-preview+json',
        "Authorization": "Bearer #{github_token}",
        "User-Agent": user_agent
      }
    end

    def request_http
      http = Net::HTTP.new('api.github.com', 443)
      http.use_ssl = true
      response = yield(http)
      raise "#{response.message}: #{response.body}" if response.code.to_i >= 300

      JSON.parse(response.body)
    end
  end
end
