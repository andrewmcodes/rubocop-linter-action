# frozen_string_literal: true

class Install
  attr_reader :config

  def initialize(config)
    @config = config
  end

  def run
    return system("gem install rubocop") unless config

    install_gems
  end

  private

  def install_gems
    return system("bundle install") if config.fetch("bundle", false)

    system("gem install #{versions}")
  end

  def versions
    gems = config.fetch("versions", [])
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
