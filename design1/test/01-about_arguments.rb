require "#{File.dirname(__FILE__)}/helper.rb"

class MethodArgumentsTest < Test::Unit::TestCase

  describe "Functions without arguments" do

    def hello
      "Hello World"
    end

    test "Calling function with parens" do
      assert_equal __, hello()
    end

    test "Calling without parens" do
      return
      assert_equal __, hello
    end

    test "Parens on method calls matter sometimes" do
      return
      hello = "Hello Local Variable"
      assert_equal __, hello
      assert_equal __, hello()
    end

  end

  describe "functions with one required argument" do
    
     def hello(name)
       "Hello #{name}"
     end

     test "Calling function with parens" do
       return
       msg = hello("Greg")
       assert_equal __, msg
     end

     test "Calling without parens" do
       return
       msg = hello "Greg"
       assert_equal __, msg
     end

     test "Methods with arguments won't be confused with local variables" do
       return
       hello = "Hi there Mr. Local Variable"
       msg = hello "Greg"
       assert_equal __, msg
     end

     test "But omitting parens can still be dangerous" do
       return
       # NOTE: not a syntactically valid ruby line, uncomment to verify
       # assert_equal __, hello "Greg"

       # NOTE: it might seem like this should fix it, but it doesn't.
       # assert_equal(__, hello "Greg")

       # This will do the trick, though
       assert_equal __, hello("Greg")
     end

  end

  describe "a function with many required arguments" do
    def distance(x1, y1, x2, y2)
      Math.hypot(x2-x1, y2-y1)
    end

    test "calling with all required arguments" do
      return
      assert_equal __, distance(0,0,3,0)
      assert_equal __, distance(3,0,0,4)
      assert_equal __, distance(4,1,1,5)
    end

    test "calling with less than the required arguments" do
      return

      # What is the class of the exception raised
      error = assert_raises(___) do
        distance(0,0,0)
      end

      # What pattern would validate the error message?
      assert_match /#{__}/, error.message
    end

    test "calling with more than required arguments" do
      return

      error = assert_raises(___) do
        distance(0,0,1,1,5)
      end

      assert_match /#{__}/, error.message
    end

  end

  describe "When all arguments are optional" do

    def story(a="Matz",b="is",c="nice")
      "#{a} #{b} #{c}"
    end

    test "function may be called with no arguments" do
      return
      assert_equal __, story
    end

    test "arguments are processed from left-to-right" do
      return
      assert_equal __, story("We","are")
    end

  end

end


