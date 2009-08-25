require "#{File.dirname(__FILE__)}/helper.rb"

# Blocks aren't just for immediate execution.

class CallBackTest < Test::Unit::TestCase

  test "you've probably already seen blocks as callbacks" do
    a = Hash.new { |h,k| h[k] = [] }
    a[:x] << 1 << 2
    a[:y] << 3 << 4

    assert_equal __, a
  end

  class Command
    def initialize(&block)
      @block = block
    end

    def execute
      @block.call
    end
  end

  _test "it's easy to use this technique with your own objects" do
    c = Command.new { Time.now }

    time1 = c.execute
    time2 = c.execute

    # make this test pass using the times above
    assert __ < __
  end


  class FilterChain

    def initialize
      @conditions = []
    end

    def condition(&block)
      @conditions << block
      self
    end

    def reduce(enum)
      enum.select { |x| @conditions.all? { |f| f[x] } }
    end

  end

  _test "You can even store a collection of callbacks" do
    filter = FilterChain.new

    # come up with a chain of condition() calls to make this test pass.
    
    assert_equal [2,4,6], filter.reduce(1..20)
  end



end
