=begin
  Author: Gail Chen
  Created: 6/13
  Edit: N/A
  Description: This module has methods related to getting valid user's choice
  of which website to scrape.
=end
require_relative './Jsonify'
require_relative './EmailUtils'
module WebChoice
  include Jsonify
  include EmailUtils

=begin
  	Description:
  		Prints websites that are available to scrape to the screen and get valid
      user's choice. The user must choose a valid option by typing the number
      of that option. The method returns an integer of corresponding user's choice.
  	Requires: N/A
  	Updates: N/A
  	Returns: Integer where 1 <= Integer <= 3
=end
	def get_web_choice()
		user_choice = nil
		loop do
			puts "\nWebsites available to scrape:"
			puts "[1] OSU Residence Hall"
			puts "[2] OSU Sports"
			puts "[3] OSU Student Jobs"
			puts "Choose a website to scrape by typing the number of that option:"
			user_choice = gets.chomp
			break if valid_choice? user_choice
		end
		user_choice.to_i
	end

=begin
  	Author: Gail Chen
  	Created: 6/13
  	Edit: N/A
  	Description:
  		Checks user enters an integer between 1 and 3.
  	Requires:
  		user_input.class == String
  	Updates: N/A
  	Returns:
  		true if user_input is a string of an integer in range [1, 3], false else
=end
  def valid_choice?(user_input)
  	if user_input.length == 1 && user_input.to_i.to_s == user_input && user_input.to_i >= 1 && user_input.to_i <= 3
  		return true
  	else
  		puts "You chose " + user_input +", I have no idea what to do with that."
  		return false
  	end
  end

end
