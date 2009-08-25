require "#{File.dirname(__FILE__)}/helper.rb"

# You're welcome to try these challenges whenever you like.  It is recommended
# that unless a solution is fairly obvious to your whole team, it is better to
# run the associated basic tests before attempting these.  More experienced
# team members can help teach their teammates the fundamentals.  
#
# Then, come back and tackle the challenge problems when your whole team is
# ready.

class ChallengingTest < Test::Unit::TestCase


  describe "Arguments challenge" do

    # distance(1,2) -- distance of [1,2] from origin [0,0]
    # distance(1,2,3,4) -- distance of [1,2] from [3,4]
    # distance([1,2]) -- distance of [1,2] from origin [0,0]
    # distance([1,2], :to => [3,4]) -- distance of [1,2], from [3,4]
    # distance([1,2],[3,4]) -- distance of [1,2] from [3,4]
    #
    def distance(*args)
      # implement this.
    end

    # NOTE: Try 01-about_arguments.rb if this looks daunting
    test "Ridiculously flexible argument processing" do
      assert_equal 5, distance(5,0)
      assert_equal 5, distance(6,2,3,6)
      assert_equal 2, distance([2,0])
      assert_equal 10, distance([12,4], :to => [6,12])
      assert_equal 10, distance([12,4],[6,12])

      assert_raises(ArgumentError) do
        distance(1,2,3)
      end

      assert_raises(ArgumentError) do
        distance(1,:kitten)
      end
    end

  end

  describe "Code blocks challenge" do

    class FilterChain
      # complete this implementation

      def condition
        self
      end

      def to_proc
        lambda { |x| }
      end
    end

    # See 02-about_block_basics.rb, 04-about-to-proc.rb, and
    # 05-about-blocks-as-callbacks.rb if you're stuck
    #
    test "Fancy block magic combined with some to_proc love" do
      return
      filter = FilterChain.new
      filter.condition { |x| x % 2 == 0 }.
             condition { |x| x < 10 }.
             condition { |x| x**2 < 50 }

      assert_equal [2,4,6], (1..20).select(&filter)
    end


  end



end
