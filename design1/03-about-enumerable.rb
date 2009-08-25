require "#{File.dirname(__FILE__)}/helper.rb"

# Enumerable is the sweet mix-in that provides things like inject/map/select and
# friends to Ruby's Array, Hash, Set, and a whole score of other things.  Let's
# take a look at how you can make use of it in your own classes.

class EnumerableTest < Test::Unit::TestCase

  class SortedList

    include Enumerable

    def initialize
      @data = []
    end

    def <<(element)
      @data << element
      @data.sort!
      self
    end

    def [](index)
      @data[index]
    end
    
    def each
      @data.each { |e| yield(e) }
    end

  end

  test "each() yields each element in the collection" do
    list = SortedList.new
    list << 5 << 2 << 13 << 7

    data = []
    list.each { |e| data << e }
    assert_equal __, data
  end

  test "All familiar Enumerable methods hinge on each()" do
    return
    list = SortedList.new
    list << 5 << 2 << 13 << 7

    # call an appropriate Enumerable method on list to get the desired result
    assert_equal [2,5,7], __
    assert_equal [4,7,9,15], __
    assert_equal 27, __
    assert_equal [2,5,7,13], __
  end

  class BrokenEnumerable
    include Enumerable
  end

  test "Without an each, no Enumerable methods will run" do
    return
    obj = BrokenEnumerable.new
    error = assert_raises(___) do
      obj.map { |e| "Hai #{e}" }
    end

    assert_match /#{__}/, error.message
  end

  class WorthlessEnumerable
    include Enumerable

    def each
    end
  end

  test "Enumerable is useless if you never yield to a block in each" do
    return
    obj = WorthlessEnumerable.new

    assert_equal __, obj.map { |x| x + 1 }
  end
end
