# frozen_string_literal: true

class Command
  attr_reader :config

  def initialize(config)
    @config = config
  end

  def build
    return base_command unless config

    "#{check_scope} #{base_command} #{fail_level} #{rubocop_config} #{excluded}".strip.squeeze(' ')
  end

  private

  def base_command
    'rubocop --parallel -f json'
  end

  def check_scope
    return 'git diff origin/master --name-only --diff-filter=AM | xargs' if config['check_scope'] == 'modified'
  end

  def rubocop_config
    rubocop_config = config.fetch('rubocop_config_path', '')
    return "-c #{rubocop_config}" unless rubocop_config.empty?
  end

  def excluded
    excluded_cops = config.fetch('rubocop_excluded_cops', '')
    return "--except #{excluded_cops.join(' ')}" unless excluded_cops.empty?
  end

  def fail_level
    level = config.fetch('rubocop_fail_level', '')
    return "--fail-level #{level}" unless level.empty?
  end
end
