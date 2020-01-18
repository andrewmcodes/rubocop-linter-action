# typed: true

class ReportAdapter
  class << self
    CONCLUSION_TYPES = { failure: "failure", success: "success" }.freeze
    ANNOTATION_LEVELS = {
      "refactor" => "notice",
      "convention" => "notice",
      "warning" => "warning",
      "error" => "failure",
      "fatal" => "failure"
    }.freeze

    sig { params(report: T.untyped).returns(T.untyped) }
    def conclusion(report)
      return CONCLUSION_TYPES[:failure] if status_code(report).positive?

      CONCLUSION_TYPES[:success]
    end

    sig { params(report: T.untyped).returns(T.untyped) }
    def summary(report)
      "#{total_offenses(report)} offense(s) found."
    end

    sig { params(report: T.untyped).returns(T.untyped) }
    def annotations(report) # rubocop:disable Metrics/AbcSize
      report["files"].each_with_object([]) do |file, annotation_list|
        file["offenses"].each do |offense|
          location, same_line = column_check(offense["location"])
          annotation_list.push(
            {
              'path': file["path"],
              'start_line': location["start_line"],
              'end_line': location["last_line"],
              'start_column': (location["start_column"] if same_line),
              'end_column': (location["last_column"] if same_line),
              'annotation_level': annotation_level(offense["severity"]),
              'message': "#{offense['message']} [#{offense['cop_name']}]"
            }.compact.transform_keys!(&:to_s)
          )
        end
      end
    end

    private

    sig { params(location: T.untyped).returns(T.untyped) }
    def column_check(location)
      same_line = location["start_line"] == location["last_line"]
      has_columns = location["start_column"] && location["last_column"]

      if same_line && has_columns && location["start_column"] > location["last_column"]
        location["start_column"], location["last_column"] = location["last_column"], location["start_column"]
      end

      [location, same_line]
    end

    sig { params(severity: T.untyped).returns(T.untyped) }
    def annotation_level(severity)
      ANNOTATION_LEVELS[severity]
    end

    sig { params(report: T.untyped).returns(T.untyped) }
    def total_offenses(report)
      report.dig("summary", "offense_count")
    end

    sig { params(report: T.untyped).returns(T.untyped) }
    def status_code(report)
      report.dig("__exit_code")
    end
  end
end
