require "rubygems"
require "faker"
require "yaml"

data = { :employees => {}, :groups => { 1 => "accounting", 2 => "sales", 
                                        3 => "marketing", 4 => "administrative", 
                                        5 => "janitorial" } }

20.times.map do |i|
  employee_record = data[:employees][i+1] = { :first_name => Faker::Name.first_name, 
                                              :last_name  => Faker::Name.last_name,
                                              :group_id   => 1 + rand(5) }
  work_days = employee_record[:work_days] = {}
  (10 + rand(15)).times.each do |i|
    date = Date.today + (rand(30) * (rand(2).zero? ? 1 : -1))
    work_days[date] = { :clocked_hours => 4 + rand(50)*0.1, 
                        :lunch_hours => rand(30) * 0.1 }
  end
end

y data
