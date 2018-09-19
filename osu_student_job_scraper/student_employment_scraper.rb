# Author: Ariel
# Created: 6/11
# Edit: N/A
# initiate webscraper
require_relative 'Jobpost'
require_relative '../lib/WebScraper'

begin
	keyword = ARGV[0].downcase
	puts "keyword is "+ keyword
rescue
	keyword=''
end

begin
	location = ARGV[1].downcase
	puts "location is "+ location
rescue
	location=''
end

begin
	email_address = ARGV[2].downcase
	puts "email_address is "+ email_address
rescue
	email_address='osu.magic.team@gmail.com'
end

# Initiate a web scraper
scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
# Get base page object
base_page = scraper.get_base_page

form = base_page.form_with(:action => '/jobs/job-board')
# puts form
form["search"] = keyword

on_campus_checkbox=form.checkbox_with(:value=> 'On Campus')
off_campus_checkbox=form.checkbox_with(:value=> 'Off Campus')
work_from_home_checkbox=form.checkbox_with(:value=> 'Work From Home')

off_campus_checkbox.check if (location.include? "off")
on_campus_checkbox.check if (location.include? "on")
work_from_home_checkbox.check	if (location.include? "home")

# Get a list of sub page links
after_form_page=form.submit
sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
# puts sub_pages

jobpost = []
payload = []
# Create a list of housing objects from sub pages
sub_pages.each do |link|
	jobpost.push(Jobpost.new(base_page, link.click))
end
# Print housing data
jobpost.each do |post|
  payload.push(post.parse_info)
end
#generate json file
scraper.generate_json_file(payload, "student_jobs.json",path=File.dirname(__FILE__)+'/../public')
#send file as email attachement to client
scraper.send_email_by_passing_file(email_address,"student_jobs.json",path=File.dirname(__FILE__)+'/../public')
