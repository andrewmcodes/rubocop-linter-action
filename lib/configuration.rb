# typed: true
class Configuration
  DEFAULT_CONFIG_PATH = ".github/config/rubocop_linter_action.yml".freeze
  sig { returns(T.untyped) }
  attr_reader :workspace

  sig { params(workspace: T.untyped).returns(T.untyped) }
  def initialize(workspace)
    @workspace = workspace
  end

  sig { returns(T.untyped) }
  def build
    Util.read_yaml("#{workspace}/#{config_path}")
  end

  private

  sig { returns(T.untyped) }
  def config_path
    ENV["INPUT_ACTION_CONFIG_PATH"] || DEFAULT_CONFIG_PATH
  end
end
