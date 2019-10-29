# frozen_string_literal: true

class ReportAdapter
  class << self
    CONCLUSION_TYPES = { failure: 'failure', success: 'success' }.freeze
    ANNOTATION_LEVELS = {
      'refactor' => 'failure',
      'convention' => 'failure',
      'warning' => 'warning',
      'error' => 'failure',
      'fatal' => 'failure'
    }.freeze

    def conslusion(report)
      return CONCLUSION_TYPES[:failure] if total_offenses(report).positive?

      CONCLUSION_TYPES[:success]
    end

    def summary(report)
      "#{total_offenses(report)} offense(s) found"
    end

    def annotations(report)
      annotation_list = []
      count = 0
      report['files'].each do |file|
        file['offenses'].each do |offense|
          count += 1
          return annotation_list if count == 48

          location = offense['location']
          annotation_list.push(
            'path' => file['path'],
            'start_line' => location['start_line'],
            'end_line' => location['last_line'],
            'annotation_level' => annotation_level(offense['severity']),
            'message' => offense['message']
          )
        end
      end
    end

    private

    def annotation_level(severity)
      ANNOTATION_LEVELS[severity]
    end

    def total_offenses(report)
      report.dig('summary', 'offense_count')
    end
  end
end
