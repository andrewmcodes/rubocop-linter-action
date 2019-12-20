# frozen_string_literal: true

class Results
  attr_accessor :output, :status_code
  def initialize(command)
    @output = `#{command}`
    @status_code = $?.to_i # rubocop:disable Style/SpecialGlobalVars
  end

  def build
    insert_exit_code
    parsed_results
  end

  private

  def parsed_results
    @parsed_results ||= JSON.parse(output)
  end

  def insert_exit_code
    parsed_results["__exit_code"] = status_code
  end
end
