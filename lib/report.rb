# typed: strict

class Report
  extend T::Sig

  sig { returns(Github::Data) }
  attr_reader :github_data

  sig { returns(String) }
  attr_reader :command

  sig { params(github_data: Github::Data, command: String).void }
  def initialize(github_data, command)
    @github_data = github_data
    @command = command
  end

  sig { returns(T.nilable(T::Hash[String, String])) }
  def build
    report_path ? Util.read_json(T.must(report_path)) : results
  end

  private

  sig { returns(T.nilable(String)) }
  def report_path
    ENV["REPORT_PATH"]
  end

  sig { returns(T.nilable(T::Hash[String, String])) }
  def results
    Results.new(command).build
  end
end
