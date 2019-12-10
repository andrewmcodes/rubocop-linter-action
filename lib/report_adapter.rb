# frozen_string_literal: true

class ReportAdapter
  class << self
    CONCLUSION_TYPES = { failure: 'failure', success: 'success' }.freeze
    ANNOTATION_LEVELS = {
      'refactor' => 'notice',
      'convention' => 'notice',
      'warning' => 'warning',
      'error' => 'failure',
      'fatal' => 'failure'
    }.freeze

    def conclusion(report)
      return CONCLUSION_TYPES[:failure] if status_code(report).positive?

      CONCLUSION_TYPES[:success]
    end

    def summary(report)
      corrected_count = total_corrected_offenses(report)
      message = "#{total_offenses(report)} offense(s) found."
      message = "#{message} #{corrected_count} offsense(s) corrected." if corrected_count > 0
      message
    end

    def annotations(report) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      annotation_list = []
      count = 0
      corrected = 0
      report['files'].each do |file|
        file['offenses'].each do |offense|
          count += 1
          return annotation_list if count == 48

          location = offense['location']
          same_line = location['start_line'] == location['last_line']
          annotation_list.push(
            {
              'path': file['path'],
              'start_line': location['start_line'],
              'end_line': location['last_line'],
              'start_column': (location['start_column'] if same_line),
              'end_column': (location['last_column'] if same_line),
              'annotation_level': annotation_level(offense['severity']),
              'message': "#{offense['message']} [#{offense['cop_name']}]"
            }.compact.transform_keys!(&:to_s)
          )
        end
      end
      annotation_list
    end

    private

    def annotation_level(severity)
      ANNOTATION_LEVELS[severity]
    end

    def total_offenses(report)
      report.dig('summary', 'offense_count')
    end

    def status_code(report)
      report.dig('__exit_code')
    end
  end
end
