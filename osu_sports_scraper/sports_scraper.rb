# Author: Channing Jacobs
# Date: 6/11/18
# Editor: N/A
# Main file for osu sports page scraping

require_relative '../lib/WebScraper' # class using mechanize
require_relative './sport.rb' # parser for sport page

# Default entry point
domain_name = 'http://www.ohiostatebuckeyes.com/'
scraper = WebScraper.new(domain_name)
# Check that first user arg is a valid sport
case ARGV[0]
when "baseball","basketball","football","lacrosse","soccer","tennis"
  sport_name = ARGV[0]
when "hockey"
  sport_name = "ice " + ARGV[0]
else
  Kernel.abort("Sport not recognized. Please read the README.")
end
# Get the sub-pages for the selected sport
sport_pages = scraper.get_sub_page("/sports/.*body.html", "#{sport_name}")
# Choose the sport page based on male or female arg 2
if ARGV[1] == "m"
  sport = Sport.new(sport_pages[0].click)
elsif ARGV[1] == "w" && ARGV[0] != "baseball" && ARGV[0] != "football"
  sport = Sport.new(sport_pages[1].click)
elsif ARGV[1] == "w"
  Kernel.abort("#{ARGV[0]} does not have a women's team. Please read the README.")
else
  Kernel.abort("Gender not recognized. Please read the README.")
end
# Generate JSON for use in display webpage

scraper.generate_json_file(sport.generate_hash, "sport.json")
