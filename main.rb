# Author: Ariel
# Created: 6/11
# Edit: Gail 6/13 add cases
# Edit: Mike 6/14 modify the case of running sports scraper
# Edit: Gail 6/14 modify the case of running housing and job scraper
require './lib/WebChoice'
require_relative './lib/WebScraper'
require 'mechanize'
include WebChoice

# Get valid user's choice of which website to scrape
choice = get_web_choice

# Scrape the chosen website
case choice
when 1
	system("ruby osu_housing_scraper/housing_scraper.rb")
	# Send file as email attachement to client
	if receive_email?
		email = get_email
		send_email_by_passing_file(email,"dorm.json")
		puts "Email sent!"
	end
	system('firefox ./public/osu_housing_scraper.html')
when 2
	puts "Please choose a sport from the following list:"
	puts "baseball, basketball, hockey, tennis, soccer, football, lacrosse"
	sport = gets.chomp
	puts "Please enter a gender (m or w): "
	gender = gets.chomp.downcase
	system("ruby osu_sports_scraper/sports_scraper.rb '#{sport}' '#{gender}'")
	system('firefox ./public/osu_sport_scrapper.html')
when 3
	puts "Enter the keyword(s) to search:"
	keyword = gets.chomp
	puts "Choose location(s) from (Off Campus, On Campus, Work From Home):"
	location = gets.chomp
	email = get_email
	system("ruby osu_student_job_scraper/student_employment_scraper.rb '#{keyword}' '#{location}' #{email}")
end

# Print the message saying the scraping is finished
puts "Your web scrapper successfully finished."
