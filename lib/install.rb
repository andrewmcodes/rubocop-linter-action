# typed: strict

class Install
  extend T::Sig

  DEFAULT_DEPENDENCIES = T.let({
    "rubocop" => "latest"
  }.freeze, T::Hash[T.untyped, T.untyped])

  # sig { returns(T::Hash[T.untyped, T.untyped]) }
  attr_reader :config

  sig { params(config: T.untyped).returns(T.untyped) }
  def initialize(config)
    @config = Hash(config)
  end

  sig { returns(T.nilable(T::Boolean)) }
  def run
    return system("bundle install") if config.fetch("bundle", false)

    system("gem install #{dependencies}")
  end

  private

  sig { returns(String) }
  def dependencies
    DEFAULT_DEPENDENCIES.merge(custom_dependencies).map(&method(:version_string)).join(" ")
  end

  sig { returns(T.any(NilClass, T::Hash[String, String])) }
  def custom_dependencies
    Hash[config.fetch("versions", []).map(&method(:version))]
  end

  sig { params(dependency: T.any(T::Hash[T.untyped, T.untyped], String)).returns(String) }
  def version(dependency)
    case dependency
    when Hash
      dependency.first
    else
      [dependency, "latest"]
    end
  end

  sig { params(dependency: String, version: String).returns(String) }
  def version_string(dependency, version)
    version == "latest" ? dependency : "#{dependency}:#{version}"
  end
end
