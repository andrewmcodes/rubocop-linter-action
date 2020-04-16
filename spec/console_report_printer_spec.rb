# frozen_string_literal: true

require "./spec/spec_helper"

describe ConsoleReportPrinter do
  let(:rubocop_report) { JSON(File.read("./spec/fixtures/report.json")) }

  subject { described_class.new(results: rubocop_report, report_adapter: ReportAdapter) }

  context "has offences" do
    it "reports offences" do
      output = subject.build_output
      lines = output.split("\n")
      expect(lines[1]).to eq("201 offense(s) found.")
      expect(lines[3]).to eq(
        "Gemfile:1:1 notice: Missing magic comment `#"\
        " frozen_string_literal: true`. [Style/FrozenStringLiteralComment]"
      )
      expect(lines.length).to eq(201 + 4)
    end
  end

  context "does not have offences" do
    it "does not report offences" do
      rubocop_report["files"] = []
      rubocop_report["summary"]["offense_count"] = 0
      expect(subject.build_output).to eq("Rubocop Run Results\n0 offense(s) found.\n")
    end
  end
end
