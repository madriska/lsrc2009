require "#{File.dirname(__FILE__)}/helper.rb"

class SugaryBlockInterfaceTest < Test::Unit::TestCase

  class ChatBot
    def initialize
      @handlers = []
    end

    def handle(regexp, &block)
      @handlers << [regexp, block]
    end

    def self.build(&block)
      # finish implementing this
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

  test "Using a bare instance_eval call" do
    bot = ChatBot.new
    bot.instance_eval do
      handle(/hello/i) { "Hi there!" }
      handle(/my name is (\w+)/i) { |m| "Nice to meet you #{m[1]}" }
      # need to add a handle here...

    end

    assert_equal __, bot.reply_to("Hello")
    assert_equal __, bot.reply_to("My name is Greg")

    # add a single handle above to make these pass
    assert_equal "Really? I hate cheese", bot.reply_to("I love cheese")
    assert_equal "Really? I hate muffins", bot.reply_to("I love muffins")
  end

  _test "Building an instance_eval based DSL" do
    # implement build in the class definition above
    bot = ChatBot.build do
      handle(/hello/i) { "Hi there!" }
      handle(/my name is (\w+)/i) { |m| "Nice to meet you #{m[1]}" }
    end

    assert_equal "Hi there!", bot.reply_to("Hello")
    assert_equal "Nice to meet you Matz", bot.reply_to("My name is Matz")
  end

  describe "The problem with instance_eval" do

    setup do
      @name = "Gregory Brown"
    end

    # NOTE: You need to get ChatBot.build working before attempting this test
    _test "instance_eval changes self within the block" do

      # this passes!
      assert_equal @name, "Gregory Brown"

      bot = ChatBot.build do
        handle(/hello/i) { "You are #{@name}" }
      end

      assert_equal __, bot.reply_to("Hello")
    end

  end
  
  describe "The hybrid approach to block-centric DSLs" do
    setup do
      @name = "Gregory Brown"
    end


  end

end
