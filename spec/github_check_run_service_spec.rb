# frozen_string_literal: true

require "./spec/spec_helper"

describe Github::CheckRunService do
  let(:rubocop_report) { double(build: JSON(File.read("./spec/fixtures/report.json"))) }
  let(:github_data) { Github::Data.new(event) }
  subject do
    Github::CheckRunService.new(
      report: rubocop_report,
      github_data: github_data,
      report_adapter: ReportAdapter,
      check_name: "Test"
    )
  end

  it "#run" do
    stub_request(:any, "https://api.github.com/repos/owner/repository_name/check-runs/id")
      .to_return(status: 200, body: '{"__exit_code":0}')

    stub_request(:any, "https://api.github.com/repos/owner/repository_name/check-runs")
      .to_return(status: 200, body: '{"id": "id", "__exit_code":1}')

    expect(subject.run).to be_a(Hash)
  end
end
