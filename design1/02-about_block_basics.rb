require "#{File.dirname(__FILE__)}/helper.rb"

# We all know how to use blocks, as they're everywhere in Ruby.
# But how do the nuts and bolts work at the method definition level?
#
# These tests will touch on some of the basic concepts, be sure to rely on the
# collective knowledge of your team to fill in the rest, and if anything isn't
# clear, just ask!

class BlockBasicsTest < Test::Unit::TestCase

  def foo
    "does nothing interesting"
  end

  # NOTE: This test will pass.  play around with it and make it fail if you wish
  test "all ruby methods accept blocks, but many don't do anything with them" do
    assert_nothing_raised do
      foo { raise }
      # an error will never be raised because the block never gets called.
      # what sorts of pitfalls do you see here?
    end
  end

  describe "the yield keyword" do

    def trivial
      "Got from the block: #{yield}"
    end

    test "executes the block attached to a method" do
      assert_equal __, trivial { 1 + 1 }
      assert_equal __, trivial { "elloH".reverse }
    end

    _test "raises an error when block is not provided" do
      assert_raises(___) do
        trivial
      end
    end

    def trivial4
      yield
      yield
      yield
      yield
    end

    _test "executes the block every time yield is called" do
      i = 0
      trivial4 { i += 1 }
      assert_equal __, i
    end

    def with2
      yield(2)
    end

    _test "can pass arguments to the block" do
      assert_equal __, with2 { |x| x + 3 }
      assert_equal __, with2 { |x| "Terminator #{x}" }
    end

    _test "block variables do not pollute enclosing scope" do
      with2 { |x| x + 3 }
      assert_raises(___) { x } 
    end

  end

  describe "blocks as Proc objects" do

    def identity(&block)
      block
    end

    _test "If a block is not provided, you'll get a nil value" do
      assert_equal __, identity
    end

    def block_as_proc(&block)
      "I got you #{block.call('otomustaM .rM')}"
    end

    def delegator(&block)
      block_as_proc(&block) + " and I'll never let you go!"
    end

    _test "uses the same block syntax as when using yield" do
      # fill in using block_as_proc() with an appropriate block argument
      assert_equal "I got you Mr. Matsumoto", __  
    end

    _test "but can be used for delegation" do
      assert_equal __, delegator { |x| x.reverse }
    end

    def how_many_block_args?(&block)
      block.arity
    end

    _test "Determining number of block arguments with Proc#arity" do
      assert_equal __, how_many_block_args? { |a,b| "never gets called" }
      assert_equal __, how_many_block_args? { |a,b,c| "never gets called" }
      assert_equal __, how_many_block_args? { |a,*b| "never gets called" }
      assert_equal __, how_many_block_args? { |a,b,*c| "never gets called" }
      assert_equal __, how_many_block_args?  {|*a| "never gets called" }
      assert_equal __, how_many_block_args? {|| "never gets called" }

      # Why is this not zero?
      assert_equal __, how_many_block_args? { "never gets called" }
    end

  end

end
