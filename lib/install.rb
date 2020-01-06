# frozen_string_literal: true

class Install
  DEFAULT_DEPENDENCIES = %w[rubocop].freeze

  attr_reader :config

  def initialize(config)
    @config = Hash(config)
  end

  def run
    return system("bundle install") if config.fetch("bundle", false)

    system("gem install #{dependencies}")
  end

  private

  def dependencies
    config.fetch("versions", DEFAULT_DEPENDENCIES).map(&method(:dependency)).join(" ")
  end

  def dependency(gem)
    case gem
    when Hash
      name, version = gem.first
      version == "latest" ? name : "#{name}:#{version}"
    else
      gem
    end
  end
end
