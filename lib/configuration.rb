# frozen_string_literal: true

class Configuration
  DEFAULT_CONFIG_PATH = ".github/config/rubocop_linter_action.yml"
  attr_reader :workspace

  def initialize(workspace)
    @workspace = workspace
  end

  def build
    `pwd`
    `ls`
    Util.read_yaml("#{workspace}/#{config_path}")
  end

  private

  def config_path
    ENV['INPUT_ACTION_CONFIG_PATH'] || DEFAULT_CONFIG_PATH
  end
end
