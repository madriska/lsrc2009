require "yaml"

class DataProcessor
  def initialize(file, period_start_date)
    @data = YAML.load_file(file)
    @start_date = period_start_date
    @end_date   = @start_date + 13
  end

  attr_reader :start_date, :end_date

  def employees
    @data[:employees]
  end

  def work_days_by_week(employee)
     by_week_data = [{},{}]

     employee[:work_days].each do |date, data|
       next unless (start_date..end_date).include?(date)
       week = (start_date + 6 >= date) ? 0 : 1
       by_week_data[week][date] = data
     end
     
     by_week_data
  end

  def billed_hours_by_week(employee)
    data = work_days_by_week(employee)
    data.map do |week|
      week.inject(0) do |sum, (date, data)|
        sum + (data[:clocked_hours] - data[:lunch_hours])
      end
    end
  end

  def processed_data
    employees.each_with_object({}) do |(id, data), processed|
      employee_name = "#{data[:first_name]} #{data[:last_name]}"
      processed[employee_name] = billed_hours_by_week(data)
    end
  end

  attr_reader :data
end

if __FILE__ == $PROGRAM_NAME
  require "test/unit"

  class DataProcessorTest < Test::Unit::TestCase
    def setup
       @processor = DataProcessor.new("time_data.yml", Date.civil(2009,8,22))
    end

    def test_should_parse_yaml_data
      assert_equal 20, @processor.data[:employees].size
    end

    def test_should_provide_easy_access_to_employees
      assert_equal 20, @processor.employees.size
    end

    def test_work_days_by_week
      week1, week2 = @processor.work_days_by_week(@processor.employees[1])
      assert_equal 3, week1.size
      assert_equal 4, week2.size 
    end

    def test_billed_hours_by_week
      week1, week2 = @processor.billed_hours_by_week(@processor.employees[1])

      assert_in_delta 14.9, week1, 0.000001
      assert_in_delta 22.0, week2, 0.000001
    end

    def test_processed_data
      data = @processor.processed_data 
      assert_equal 20, data.size

      name, hours = data.find { |name,hours| name == "Makenna Kautzer" }

      assert_equal "Makenna Kautzer", name
      assert_in_delta 14.9, hours[0], 0.000001
      assert_in_delta 22.0, hours[1], 0.000001
    end
  end
end
