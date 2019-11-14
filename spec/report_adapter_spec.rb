# frozen_string_literal: true

require './spec/spec_helper'

describe ReportAdapter do
  let(:rubocop_report) do
    JSON(File.read('./spec/fixtures/report.json'))
  end

  let(:adapter) { ReportAdapter }

  it '.conclusion' do
    result = adapter.conclusion(rubocop_report)
    expect(result).to eq('failure')
  end

  it '.summary' do
    result = adapter.summary(rubocop_report)
    expect(result).to eq('201 offense(s) found')
  end

  context 'when error is on the same line' do
    it '.annotations' do
      result = adapter.annotations(rubocop_report)
      expect(result.first).to eq(
        'path' => 'Gemfile',
        'start_line' => 1,
        'end_line' => 1,
        'start_column' => 1,
        'end_column' => 1,
        'annotation_level' => 'failure',
        'message' => 'Missing magic comment `# frozen_string_literal: true`. [Style/FrozenStringLiteralComment]'
      )
    end
  end

  context 'when error is not on the same line' do
    it '.annotations' do
      result = adapter.annotations(rubocop_report)
      expect(result[1]).to eq(
        'path' => 'Gemfile',
        'start_line' => 50,
        'end_line' => 65,
        'annotation_level' => 'failure',
        'message' => 'Method has too many lines. [15/10] [Metrics/MethodLength]'
      )
    end
  end
end
