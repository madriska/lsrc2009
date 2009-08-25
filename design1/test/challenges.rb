require "#{File.dirname(__FILE__)}/helper.rb"

# You're welcome to try these challenges whenever you like.  It is recommended
# that unless a solution is fairly obvious to your whole team, it is better to
# run the associated basic tests before attempting these.  More experienced
# team members can help teach their teammates the fundamentals.  
#
# Then, come back and tackle the challenge problems when your whole team is
# ready.

class ChallengingTest < Test::Unit::TestCase

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
