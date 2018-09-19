=begin
	Author: Gail Chen
	Created: 6/14
	Edit: N/A
	Test plan for testing valid_choice method:
	- Return true
		1. user_input = "1"
		2. user_input = "2"
		3. user_input = "3"
	- max = 8, Return false
		1. user_input = "0"
		2. user_input = "4"
		3. user_input = "a"
		4. user_input = "10"
		5. user_input = "3a"
		6. user_input = "2ba"
=end

require_relative "../lib/WebChoice.rb"
require "test/unit"

class TestValidChoice < Test::Unit::TestCase
  include WebChoice

	# True Case 1. user_input = "1"
	def test_valid_choice_true_1
		user_input = "1"
		assert_equal true, valid_choice?(user_input)
	end

	# True Case 2. user_input = "2"
	def test_valid_choice_true_2
		user_input = "2"
		assert_equal true, valid_choice?(user_input)
	end

	# True Case 3. user_input = "3"
	def test_valid_choice_true_3
		user_input = "3"
		assert_equal true, valid_choice?(user_input)
	end

	# False Case 1. user_input = "0"
	def test_valid_choice_false_1
		user_input = "0"
		assert_equal false, valid_choice?(user_input)
	end

	# False Case 2. user_input = "4"
	def test_valid_choice_false_2
		user_input = "4"
		assert_equal false, valid_choice?(user_input)
	end

	# False Case 3. user_input = "a"
	def test_valid_choice_false_3
		user_input = "a"
		assert_equal false, valid_choice?(user_input)
	end

  # False Case 4. user_input = "10"
  def test_valid_choice_false_4
    user_input = "10"
    assert_equal false, valid_choice?(user_input)
  end

  # False Case 5. user_input = "3a"
  def test_valid_choice_false_5
    user_input = "3a"
    assert_equal false, valid_choice?(user_input)
  end

  # False Case 6. user_input = "2ba"
  def test_valid_choice_false_6
    user_input = "2ba"
    assert_equal false, valid_choice?(user_input)
  end

end
