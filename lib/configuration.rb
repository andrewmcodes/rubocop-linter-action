# typed: strict

class Configuration
  extend T::Sig

  DEFAULT_CONFIG_PATH = T.let(".github/config/rubocop_linter_action.yml".freeze, String)
  sig { returns(String) }
  attr_reader :workspace

  sig { params(workspace: String).void }
  def initialize(workspace)
    @workspace = workspace
  end

  sig { returns(T.nilable(T::Hash[String, String])) }
  def build
    Util.read_yaml("#{workspace}/#{config_path}")
  end

  private

  sig { returns(String) }
  def config_path
    ENV["INPUT_ACTION_CONFIG_PATH"] || DEFAULT_CONFIG_PATH
  end
end
