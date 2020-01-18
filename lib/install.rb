# typed: ignore

class Install
  DEFAULT_DEPENDENCIES = {
    "rubocop" => "latest"
  }.freeze

  sig { returns(T.untyped) }
  attr_reader :config

  sig { params(config: T.untyped).returns(T.untyped) }
  def initialize(config)
    @config = Hash(config)
  end

  sig { returns(T.untyped) }
  def run
    return system("bundle install") if config.fetch("bundle", false)

    system("gem install #{dependencies}")
  end

  private

  sig { returns(T.untyped) }
  def dependencies
    DEFAULT_DEPENDENCIES.merge(custom_dependencies).map(&method(:version_string)).join(" ")
  end

  sig { returns(T.untyped) }
  def custom_dependencies
    Hash[config.fetch("versions", []).map(&method(:version))]
  end

  sig { params(dependency: T.untyped).returns(T.untyped) }
  def version(dependency)
    case dependency
    when Hash
      dependency.first
    else
      [dependency, "latest"]
    end
  end

  sig { params(dependency: T.string, version: T.string).returns(T.string) }
  def version_string(dependency, version)
    version == "latest" ? dependency : "#{dependency}:#{version}"
  end
end
