# frozen_string_literal: true

require './spec/spec_helper'

describe GithubCheckRunService do
  let(:rubocop_report) { JSON(File.read('./spec/fixtures/report.json')) }
  let(:github_data) { { sha: 'sha', token: 'token', owner: 'owner', repo: 'repository_name' } }
  let(:service) { GithubCheckRunService.new(rubocop_report, github_data, ReportAdapter) }

  it '#run' do
    stub_request(:any, 'https://api.github.com/repos/owner/repository_name/check-runs/id')
      .to_return(status: 200, body: '{}')

    stub_request(:any, 'https://api.github.com/repos/owner/repository_name/check-runs')
      .to_return(status: 200, body: '{"id": "id"}')

    output = service.run
    expect(output).to be_a(Hash)
  end
end
