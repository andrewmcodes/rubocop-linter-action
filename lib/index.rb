# frozen_string_literal: true

# requires ...................................................................
require "net/http"
require "json"
require "time"
require "yaml"

# require relatives ..........................................................
require_relative "./configuration"
require_relative "./command"
require_relative "./github/check_run_service"
require_relative "./github/client"
require_relative "./github/data"
require_relative "./install"
require_relative "./report"
require_relative "./report_adapter"
require_relative "./results"
require_relative "./util"

class RubocopLinterAction
  def self.run
    new.run
  end

  def run
    install_gems
    run_check_run_service
  end

  private

  def config
    @config ||= Configuration.new(github_data.workspace).build
  end

  def github_data
    @github_data ||= Github::Data.new(Util.read_json(ENV["GITHUB_EVENT_PATH"]))
  end

  def install_gems
    Install.new(config).run
  end

  def command
    Command.new(config).build
  end

  def report
    Report.new(github_data, command)
  end

  def run_check_run_service
    Github::CheckRunService.new(
      report: report,
      github_data: github_data,
      report_adapter: ReportAdapter,
      check_name: check_name
    ).run
  end

  def check_name
    config.fetch("check_name", "Rubocop Action")
  end
end

RubocopLinterAction.run
