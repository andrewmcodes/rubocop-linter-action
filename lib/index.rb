# frozen_string_literal: true

require 'net/http'
require 'json'
require 'time'
require_relative './report_adapter'
require_relative './github_check_run_service'
require_relative './github_client'

def read_json(path)
  JSON.parse(File.read(path))
end

@event_json = read_json(ENV['GITHUB_EVENT_PATH']) if ENV['GITHUB_EVENT_PATH']
@github_data = {
  sha: ENV['GITHUB_SHA'],
  token: ENV['GITHUB_TOKEN'],
  owner: ENV['GITHUB_REPOSITORY_OWNER'] || @event_json.dig('repository', 'owner', 'login'),
  repo: ENV['GITHUB_REPOSITORY_NAME'] || @event_json.dig('repository', 'name')
}

@rubocop = "rubocop --parallel -f json"
@rubocop += " -L" + ENV["INPUT_FILE_PATHS"] if ENV["INPUT_FILE_PATHS"] != ""
@rubocop += " -c " + ENV["INPUT_CONFIG_PATH"] if ENV["INPUT_CONFIG_PATH"] != ""
@rubocop += " --except " + ENV["INPUT_EXCLUDED_COPS"] if ENV["INPUT_EXCLUDED_COPS"] != ""
@rubocop += " --fail-level " + ENV["INPUT_FAIL_LEVEL"]

@report =
  if ENV['REPORT_PATH']
    read_json(ENV['REPORT_PATH'])
  else
    Dir.chdir(ENV['GITHUB_WORKSPACE']) {
      JSON.parse(`#{@rubocop}`)
    }
  end

GithubCheckRunService.new(@report, @github_data, ReportAdapter).run
