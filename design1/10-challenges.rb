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

    class Transformer
      # complete this implementation
      
      def mutation(&block)
        self
      end

      # HINT: This should perform function composition
      def to_proc
        lambda { |x| }
      end
    end

    # See 02-about_block_basics.rb, 04-about-to-proc.rb, and
    # 05-about-blocks-as-callbacks.rb if you're stuck
    #
    test "Fancy block magic combined with some to_proc love" do
      transformer = Transformer.new
      transformer.mutation { |x| x + 2 }.
                  mutation { |x| x * 5 }.
                  mutation { |x| x / 3 }

      assert_equal [5,6,8,10,11], (1..5).map(&transformer)
    end

    describe "A hybrid block based DSL" do

      class ChatBot
        def initialize
          @handlers = []
        end

        def handle(regexp, &block)
          @handlers << [regexp, block]
        end

        def self.build(&block)
          # finish implementing this based on tests below
          
          new
        end

        def reply_to(message)
          @handlers.each do |pattern, block|
            if match_data = message.match(pattern)
              return block.call(match_data)
            end
          end

          "I am very angry, because I didn't understand"
        end
      end

      # NOTE: The trick here is to use Proc#arity, explained in
      # 02-about_block_basics.rb , combined with the ideas in
      # 07-about-blocks-as-interface-sugar.rb

      _test "When called without a block argument, use instance_eval" do
        # same test as before
        bot = ChatBot.build do
          handle(/hello/i) { "Hi there!" }
          handle(/my name is (\w+)/i) { |m| "Nice to meet you #{m[1]}" }
        end

        assert_equal "Hi there!", bot.reply_to("Hello")
        assert_equal "Nice to meet you Matz", bot.reply_to("My name is Matz")
      end

      _test "When called with a block argument, pass the instantiated bot" do
         @name = "Keyser Soze"

         bot = ChatBot.build do |b|
           b.handle(/who am i/i) { "You are #{@name}" }
         end

         assert_equal "You are Keyser Soze", bot.reply_to("Who am I?")
      end

    end

  end

end
