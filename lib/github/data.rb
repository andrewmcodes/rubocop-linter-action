# typed: ignore

module Github
  class Data
    extend T::Sig

    sig { returns(T.untyped) }
    attr_reader :event

    sig { params(event: T.untyped).returns(T.untyped) }
    def initialize(event)
      @event = event
    end

    sig { returns(T.untyped) }
    def sha
      ENV["GITHUB_SHA"]
    end

    sig { returns(T.untyped) }
    def token
      ENV["GITHUB_TOKEN"]
    end

    sig { returns(T.untyped) }
    def owner
      ENV["GITHUB_REPOSITORY_OWNER"] || event.dig("repository", "owner", "login")
    end

    sig { returns(T.untyped) }
    def repo
      ENV["GITHUB_REPOSITORY_NAME"] || event.dig("repository", "name")
    end

    sig { returns(T.untyped) }
    def workspace
      ENV["GITHUB_WORKSPACE"]
    end
  end
end
