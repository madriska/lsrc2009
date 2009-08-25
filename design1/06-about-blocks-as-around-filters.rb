require "#{File.dirname(__FILE__)}/helper.rb"

class AroundFilterTest < Test::Unit::TestCase

  def returning(object, &block)
    # implement this
  end

  test "blocks can be used like little templates in methods" do
    a = [1,2,3,4]

    assert_equal [1,2,3], returning(a) { a.pop }

    b = { :a => 1, :c => 10 }

    results = returning(b) do
      b[:a] = 5
      b[:d] = 10
    end

    assert_equal({ :a => 5, :c => 10, :d => 10 }, results)
  end

  class Report
     
    attr_accessor :name, :body

    def render 
      "== #{name} ==\n\n#{body}"
    end

  end

  _test "Dull APIs are Dull" do
    report = Report.new
    report.name = "Awesome Report"
    report.body = "Not actually remotely awesome"
    results = report.render

    expected = __

    assert_equal expected, results
  end


  class Report
    def self.build
      report = new
      yield(report)
      report.render
    end
  end

  _test "But with a little block love, everyone is happy again" do
    results = Report.build do |report|
      # complete
    end

    expected = "== Awesome Report ==\n\nOnce again awesome"
    assert_equal expected, results
  end

end
