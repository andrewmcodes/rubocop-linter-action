# typed: ignore

# requires ...................................................................
require "net/http"
require "json"
require "sorbet-runtime"
require "sorbet-static"
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
  extend T::Sig

  sig { returns(T.untyped) }
  def self.run
    new.run
  end

  sig { returns(T.untyped) }
  def run
    install_gems
    run_check_run_service
  end

  private

  sig { returns(T.untyped) }
  def config
    @config ||= Configuration.new(github_data.workspace).build
  end

  sig { returns(T.untyped) }
  def github_data
    @github_data ||= Github::Data.new(Util.read_json(ENV["GITHUB_EVENT_PATH"]))
  end

  sig { returns(T.untyped) }
  def install_gems
    Install.new(config).run
  end

  sig { returns(T.untyped) }
  def command
    Command.new(config).build
  end

  sig { returns(T.untyped) }
  def report
    Report.new(github_data, command)
  end

  sig { returns(T.untyped) }
  def run_check_run_service
    Github::CheckRunService.new(
      report: report,
      github_data: github_data,
      report_adapter: ReportAdapter,
      check_name: check_name
    ).run
  end

  sig { returns(T.untyped) }
  def check_name
    config.fetch("check_name", "Rubocop Action")
  end
end

RubocopLinterAction.run
