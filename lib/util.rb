# typed: strong

class Util
  class << self
    extend T::Sig

    sig { params(path: String).returns(T::Hash[String, String]) }
    def read_json(path)
      JSON.parse(File.read(path))
    rescue Errno::ENOENT
      p "Notice: No file: #{path}"
      {}
    end

    sig { params(path: String).returns(T::Hash[String, String]) }
    def read_yaml(path)
      YAML.safe_load(File.read(path))
    rescue Errno::ENOENT
      p "Notice: No file: #{path}"
      {}
    end
  end
end
