# frozen_string_literal: true

class ConsoleReportPrinter
  attr_reader :results, :report_adapter
  def initialize(results:, report_adapter:)
    @results = results
    @report_adapter = report_adapter
  end

  def run
    puts build_output
  end

  def build_output
    lines = []
    lines << "Rubocop Run Results"
    lines << summary
    lines << ""
    annotations.each do |annotation|
      lines << build_annotation(annotation)
    end

    lines.join("\n")
  end

  private

  def annotations
    report_adapter.annotations(results)
  end

  def summary
    report_adapter.summary(results)
  end

  def build_annotation(info)
    "#{info['path']}:#{info['start_line']}:#{info['end_line']} #{info['annotation_level']}: #{info['message']}"
  end
end
