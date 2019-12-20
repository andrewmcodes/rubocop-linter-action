# frozen_string_literal: true

# requires ...................................................................
require "webmock/rspec"
require "json"
require "pry"
require "time"
require "yaml"

# require relatives ..........................................................
require_relative "./../lib/command"
require_relative "./../lib/github/check_run_service"
require_relative "./../lib/github/client"
require_relative "./../lib/github/data"
require_relative "./../lib/install"
require_relative "./../lib/report_adapter"
require_relative "./../lib/util"
require_relative "./../lib/results"
require_relative "./helpers"

ENV["GITHUB_SHA"] = "sha"
ENV["GITHUB_TOKEN"] = "token"
ENV["GITHUB_REPOSITORY_OWNER"] = "owner"
ENV["GITHUB_REPOSITORY_NAME"] = "repository_name"
ENV["GITHUB_WORKSPACE"] = "workspace"

RSpec.configure do |c|
  c.include Helpers
end
