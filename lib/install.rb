# frozen_string_literal: true

class Install
  attr_reader :config

  def initialize(config)
    @config = Hash(config)
  end

  def run
    return system("bundle install") if config.fetch("bundle", false)

    system("gem install #{versions}")
  end

  private

  def versions
    gems = config.fetch("versions", %w[rubocop])
    dependencies = gems.map(&method(:dependency)).join(" ")
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
