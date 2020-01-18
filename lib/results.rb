# typed: ignore

class Results
  sig { params(output: T.untyped).returns(T.untyped) }
  attr_accessor :output, :status_code
  sig { params(command: T.untyped).returns(T.untyped) }
  def initialize(command)
    @output = `#{command}`
    @status_code = $?.to_i # rubocop:disable Style/SpecialGlobalVars
  end

  sig { returns(T.untyped) }
  def build
    insert_exit_code
    parsed_results
  end

  private

  sig { returns(T.untyped) }
  def parsed_results
    @parsed_results ||= JSON.parse(output)
  end

  sig { returns(T.untyped) }
  def insert_exit_code
    parsed_results["__exit_code"] = status_code
  end
end
