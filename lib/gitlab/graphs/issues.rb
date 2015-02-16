module Gitlab
  module Graphs
    class Issues
      attr_reader :issues, :start_date, :end_date, :duration,
        :commits_per_month

      def initialize(issues)
        @issues = issues
        @start_date = issues.last.created_at
        @end_date = issues.first.created_at
        @duration = (@end_date.to_date - @start_date.to_date).to_i

        # collect_data
      end

      # def authors
      #   @authors ||= @issues.map(&:author_email).uniq.count
      # end

      def total_count_by_state
        Hash.new(0).merge(@issues.dup.group(:action).count)
      end

      def average_issues_per_day
        @average_issues_per_day ||= (@issues.count.to_f / @duration).round(1)
      end

      def collect_data
        @issues_per_day_of_month = {}
        (1..31).to_a.each { |day| @issues_per_day_of_month[day] = 0 }

#         @commits.each do |commit|
#           hour = commit.committed_date.strftime('%k').to_i
#           day_of_month = commit.committed_date.strftime('%e').to_i
#           weekday = commit.committed_date.strftime('%A')
#
#           @commits_per_week_days[weekday] ||= 0
#           @commits_per_week_days[weekday] += 1
#           @commits_per_time[hour] ||= 0
#           @commits_per_time[hour] += 1
#           @commits_per_month[day_of_month] ||= 0
#           @commits_per_month[day_of_month] += 1
#         end
      end
    end
  end
end
