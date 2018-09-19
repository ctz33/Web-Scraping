=begin
  Author: Gail Chen
  Created: 6/14
  Edit: N/A
  Description: Scrape data from OSU Residence Hall Website.
=end
require_relative '../lib/WebScraper'
require_relative 'housing'

# Initiate a web scraper
scraper = WebScraper.new("https://housing.osu.edu/roomsearch/")
# Get base page object
base_page = scraper.get_base_page
# Get a list of sub page links
sub_pages = scraper.get_sub_page("/roomsearch/")

housing = []
payload = []
# Create a list of housing objects from sub pages
sub_pages.each do |link|
	housing.push(Housing.new(base_page, link.click))
end

# Print housing data
housing.each do |building|
  payload.push(building.generate_hash)
end

# Generate json file
scraper.generate_json_file(payload, "dorm.json",path=File.dirname(__FILE__)+'/../public')
