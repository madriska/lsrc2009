require "#{File.dirname(__FILE__)}/helper.rb"


# So, you might have heard about Symbol#to_proc and all its hotness.  Allowing
# things like enum.map(&:to_s).  Let's take a peek behind the curtain and see
# how to_proc works in general

class ToProcTest < Test::Unit::TestCase

  class ::String

    # Almost identical to Symbol#to_proc
    def to_proc
      lambda { |x| x.send(self) }
    end
  end

  test "to_proc is not just for symbols" do
    method = "to_s"
    assert_equal __, [1,2,3].map(&method)
  end

end

