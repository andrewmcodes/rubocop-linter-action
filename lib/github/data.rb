# typed: strict

module Github
  class Data
    extend T::Sig

    sig { returns(T.nilable(String)) }
    attr_reader :event

    sig { params(event: T.nilable(String)).void }
    def initialize(event)
      @event = event
    end

    sig { returns(T.nilable(String)) }
    def sha
      ENV["GITHUB_SHA"]
    end

    sig { returns(T.nilable(String)) }
    def token
      ENV["GITHUB_TOKEN"]
    end

    sig { returns(T.nilable(String)) }
    def owner
      ENV["GITHUB_REPOSITORY_OWNER"] || T.must(event).dig("repository", "owner", "login")
    end

    sig { returns(T.nilable(String)) }
    def repo
      ENV["GITHUB_REPOSITORY_NAME"] || T.must(event).dig("repository", "name")
    end

    sig { returns(T.nilable(String)) }
    def workspace
      ENV["GITHUB_WORKSPACE"]
    end
  end
end
