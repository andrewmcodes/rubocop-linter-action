# frozen_string_literal: true

require "./spec/spec_helper"

describe ReportAdapter do
  subject { ReportAdapter }

  let(:rubocop_report) { JSON(File.read("./spec/fixtures/report.json")) }

  context "when exit code is 0" do
    it "succeedes" do
      rubocop_report["__exit_code"] = 0
      expect(subject.conclusion(rubocop_report)).to eq("success")
    end
  end

  context "when exit code is 1" do
    it { expect(subject.conclusion(rubocop_report)).to eq("failure") }
  end

  context "summary has offenses" do
    it { expect(subject.summary(rubocop_report)).to eq("201 offense(s) found.") }
  end

  context "when error is on the same line" do
    it "has start and end column keys" do
      result = subject.annotations(rubocop_report)
      expect(result.first).to eq(
        "path" => "Gemfile",
        "start_line" => 1,
        "end_line" => 1,
        "start_column" => 1,
        "end_column" => 1,
        "annotation_level" => "notice",
        "message" => "Missing magic comment `# frozen_string_literal: true`. [Style/FrozenStringLiteralComment]"
      )
    end

    context "when the start_column is larger than the end_column" do
      it "sets the end_column to the same value as start_column" do
        result = subject.annotations(rubocop_report)
        expect(result[1]).to eq(
          "path" => "Gemfile",
          "start_line" => 15,
          "end_line" => 15,
          "start_column" => 3,
          "end_column" => 4,
          "annotation_level" => "notice",
          "message" => "Final newline missing. [Layout/TrailingBlankLines]"
        )
      end
    end
  end

  context "when error is not on the same line" do
    it "does not have start and end column keys" do
      result = subject.annotations(rubocop_report)
      expect(result[2]).to eq(
        "path" => "Gemfile",
        "start_line" => 50,
        "end_line" => 65,
        "annotation_level" => "notice",
        "message" => "Method has too many lines. [15/10] [Metrics/MethodLength]"
      )
    end
  end
end
