# typed: true
class Report
  sig { returns(T.untyped) }
  attr_reader :github_data, :command

  sig { params(github_data: T.untyped, command: T.untyped).returns(T.untyped) }
  def initialize(github_data, command)
    @github_data = github_data
    @command = command
  end

  sig { returns(T.untyped) }
  def build
    report_path ? Util.read_json(report_path) : results
  end

  private

  sig { returns(T.untyped) }
  def report_path
    ENV["REPORT_PATH"]
  end

  sig { returns(T.untyped) }
  def results
    Results.new(command).build
  end
end
