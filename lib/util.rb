# frozen_string_literal: true

class Util
  class << self
    def read_json(path)
      JSON.parse(File.read(path))
    rescue Errno::ENOENT
      p "Warning: Missing file: #{path}"
      {}
    end

    def read_yaml(path)
      YAML.load(File.read(path))
    rescue Errno::ENOENT
      p "Warning: Missing file: #{path}"
      {}
    end
  end
end
