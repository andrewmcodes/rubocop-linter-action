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

    system("gem install #{rubocop} #{extensions}")
  end

  def rubocop
    version = config.fetch("rubocop_version", "latest")
    return "rubocop" if version == "latest"

    "rubocop:#{version}"
  end

  def extensions
    extensions = config.fetch("rubocop_extensions", [])
    command = []
    extensions.each do |gem|
      if gem.is_a? String
        command << gem
      else
        gem_name = gem.keys.first
        gem_version = gem.values.first
        command << "#{gem_name}#{gem_version == 'latest' ? '' : ":#{gem_version}"}"
      end
    end
    command.join(" ")
  end
end
