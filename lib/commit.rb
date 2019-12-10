# frozen_string_literal: true

class Commit
  attr_reader :github_data, :commit_message
  def initialize(github_data, commit_message)
    @github_data = github_data
    @commit_message = commit_message
  end

  def run
    setup
    commit
    push
  end

  private

  def setup
    system("git config --local user.email 'rubocop-linter-action@github.com'")
    system("git config --local user.name 'Rubocop Linter Action'")
  end

  def commit
    system('git status')
    system('git add .')
    system("git commit -m '#{commit_message}'")
  end

  def push
    system("git push '#{remote_repo}' HEAD:#{github_data.branch} --follow-tags")
  end

  def remote_repo
    "https://x-access-token:#{github_data.token}@github.com/#{github_data.owner}/#{github_data.repo}.git"
  end
end
