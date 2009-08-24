require 'yaml'

class DataProcessor
  def initialize(yaml_file, start_date)
    @data = YAML.load_file(yaml_file)
    @start_date = start_date
  end

  # TODO: this feels ugly. for testing.
  attr_reader :data

  # Number of 7-day weeks each report covers.
  ReportWeeks = 2

  # Returns an array of Date ranges spanning each week of this report.
  def week_date_ranges
    (1..ReportWeeks).map do |week|
      begin_date = @start_date + (7*(week-1))
      begin_date .. (begin_date + 6)
    end
  end

  class Employee
    def initialize(data)
      @data = data
    end

    def name
      "#{@data[:first_name]} #{@data[:last_name]}"
    end

    def net_hours_for_date(date)
      data = @data[:work_days][date]
      return 0 unless data
      data[:clocked_hours] - data[:lunch_hours]
    end

    def net_hours_for_date_range(range)
      range.inject(0) do |sum, date|
        sum + net_hours_for_date(date)
      end
    end
  end

  # Returns an Array of Arrays with employee names and weekly hours worked:
  #
  #   [
  #     ["Employee 1 Name", [week1_hours, week2_hours]],
  #     ["Employee 2 Name", [week1_hours, week2_hours]]
  #   ]
  #
  def report_data
    @data[:employees].map do |id, employee_data|
      employee = Employee.new(employee_data)
      [employee.name, week_date_ranges.map { |range| 
                        employee.net_hours_for_date_range(range)} ]
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  require 'test/unit'
  require 'rubygems'
  require 'redgreen'
  require 'contest' # github: citrusbyte/contest

  class DataProcessorTest < Test::Unit::TestCase
    context "Processor" do
      setup do
        @start_date = Date.civil(2009, 8, 22)
        @processor = DataProcessor.new("time_data.yml", @start_date)
      end

      test "week_date_ranges should span the correct range" do
        week1 = Date.civil(2009, 8, 22) .. Date.civil(2009, 8, 28)
        week2 = Date.civil(2009, 8, 29) .. Date.civil(2009, 9, 4)
        assert_equal([week1, week2], @processor.week_date_ranges)
      end

      context "Employee" do
        setup do
          @employee = DataProcessor::Employee.new(
            @processor.data[:employees][1])
        end

        test "name works and has data from YAML" do
          assert_equal "Makenna Kautzer", @employee.name
        end

        test "net_hours_for_date calculated from clocked and lunch hours" do
          assert_equal 4.5, @employee.net_hours_for_date(Date.civil(2009, 8, 1))
        end

        test "net_hours_for_date returns 0 for nonexistent dates" do
          assert_equal 0, @employee.net_hours_for_date(Date.civil(2005, 1, 1))
        end

        test "net_hours_for_date_range sums over the given range" do
          assert_equal 13.9, @employee.net_hours_for_date_range(
            Date.civil(2009, 9, 1) .. Date.civil(2009, 9, 3))
        end
      end

      context "report_data" do
        setup do
          @report_data = @processor.report_data
        end

        test "generates correct number of employee records" do
          assert_equal 20, @report_data.length
        end

        test "records have correct data" do
          # spot-check employee 1's record
          makenna = @report_data.detect{ |(name, weekly_hours)| 
                                           name == 'Makenna Kautzer' }
          assert_not_nil makenna

          weekly_hours = makenna.last
          assert_equal 2, weekly_hours.length
          
          assert_in_delta 14.9, weekly_hours[0], 0.00001
          assert_in_delta 22.0, weekly_hours[1], 0.00001
        end
      end

    end

  end
end

