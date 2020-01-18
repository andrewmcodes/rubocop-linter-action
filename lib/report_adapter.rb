# typed: strict

class ReportAdapter
  class << self
    extend T::Sig

    CONCLUSION_TYPES = T.let({ failure: "failure", success: "success" }.freeze, T::Hash[Symbol, String])
    ANNOTATION_LEVELS = T.let({
      "refactor" => "notice",
      "convention" => "notice",
      "warning" => "warning",
      "error" => "failure",
      "fatal" => "failure"
    }.freeze, T::Hash[String, String])

    sig { params(report: T::Hash[String, String]).returns(T.nilable(String)) }
    def conclusion(report)
      return CONCLUSION_TYPES[:failure] if status_code(report).positive?

      CONCLUSION_TYPES[:success]
    end

    sig { params(report: T::Hash[String, String]).returns(String) }
    def summary(report)
      "#{total_offenses(report)} offense(s) found."
    end

    sig { params(report: T::Hash[String, String]).returns(T::Array[T::Hash[String, String]]) }
    def annotations(report) # rubocop:disable Metrics/AbcSize
      T.must(report["files"]).as_null_object([]) do |file, annotation_list|
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

    sig { params(location: T::Hash[String, String]).returns(T::Array[T.any(T::Hash[String, String], T::Booolean)]) }
    def column_check(location)
      same_line = location["start_line"] == location["last_line"]
      has_columns = location["start_column"] && location["last_column"]

      if same_line && has_columns && T.must(location["start_column"]) > location["last_column"]
        T.must(location["start_column"], location["last_column"] = T.must(location["last_column"]), location["start_column"])
      end

      [location, same_line]
    end

    sig { params(severity: String).returns(T.nilable(String)) }
    def annotation_level(severity)
      ANNOTATION_LEVELS[severity]
    end

    sig { params(report: T::Hash[String, String]).returns(String) }
    def total_offenses(report)
      report.dig("summary", "offense_count")
    end

    sig { params(report: T::Hash[String, String]).returns(Integer) }
    def status_code(report)
      report.dig("__exit_code").to_i
    end
  end
end
