# typed: strict

class Results
  extend T::Sig

  sig { returns(T.nilable(String)) }
  attr_accessor :output

  sig { returns(T.nilable(String)) }
  attr_accessor :status_code

  sig { params(command: String).void }
  def initialize(command)
    @output = `#{command}`
    @status_code = $? # rubocop:disable Style/SpecialGlobalVars
  end

  sig { returns(T.nilable(T::Hash[String, String])) }
  def build
    insert_exit_code
    parsed_results
  end

  private

  sig { returns(T.nilable(T::Hash[String, String])) }
  def parsed_results
    @parsed_results ||= JSON.parse(T.must(output))
  end

  sig { void }
  def insert_exit_code
    T.must(parsed_results)["__exit_code"] = T.must(status_code)
  end
end
