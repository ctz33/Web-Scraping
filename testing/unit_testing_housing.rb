=begin
	Author: Gail Chen
	Date created: 6/8
	Edit: 6/11 Gail Add assertions to test @campus and @image
	Edit: 6/11 Gail Add and modify test cases corresponding to changes in Housing class
	Edit: 6/12 Gail Make changes corresponding to changes in Housing class
	Test plan for testing Housing class:
	1. Columbus Campus: Archer House, no learning community
	2. Columbus Campus: Morrill Tower, has a learning community
	3. Columbus Campus: Baker Hall West, has a learning community
	4. Veteran's House (address is not available), no image
	5. Wooster/ATI Campus: Franklin Court, no image, no learning community
	6. Mansfield Campus: Molyet Village Apartments, no image, no learning community
	7. Newark Campus: Newark Apartments, no image, no learning community
=end

require 'mechanize'
require_relative "../osu_housing_scraper/housing"
require "test/unit"

class TestHousing < Test::Unit::TestCase

	def test_housing_archer_house
		agent = Mechanize.new
		parent_page = agent.get("https://housing.osu.edu/roomsearch/")
		building_page = agent.get("https://housing.osu.edu/roomsearch/archer-house")
		housing = Housing.new(parent_page, building_page)
		facilities = ["Single-gender room/suite; Mixed gender wing/floor", "Kitchen Facilities", "Vending Machines", "Suite/Room Bath", "Handicap Access", "Lounge space", "Air Conditioning", "ResNet", "Own Trash Removal", "Microwave/Refrigerator", "Laundry Facilities (in complex)"]
		assert_equal "Archer House", housing.name
		assert_equal "2130 Neil Avenue", housing.address
		assert_equal "2130 Neil Avenue, Columbus, OH 43210", housing.full_address
		assert_equal "https://housing.osu.edu/posts/images/archer1-big.jpg", housing.image
		assert_equal "Columbus", housing.campus
		assert_equal "614-292-5203", housing.phone
		assert_equal facilities, housing.facility_set
		assert_equal "North", housing.area
		assert_equal "Eddie Koelzer", housing.hall_director
		assert_equal "No Learning Community", housing.learning_community
	end

	def test_housing_morrill_tower
		agent = Mechanize.new
		parent_page = agent.get("https://housing.osu.edu/roomsearch/")
		building_page = agent.get("https://housing.osu.edu/roomsearch/morrill-tower")
		housing = Housing.new(parent_page, building_page)
		facilities = ["Single-gender room/suite; Mixed gender wing/floor", "Kitchen Facilities", "Vending Machines", "Suite/Room Bath", "Study Areas", "Academic Year Housing", "Air Conditioning", "ResNet", "Lounge space", "Microwave/Refrigerator", "Laundry Facilities (in complex)"]
		assert_equal "Morrill Tower", housing.name
		assert_equal "1900 Cannon Drive", housing.address
		assert_equal "1900 Cannon Drive, Columbus, OH 43210", housing.full_address
		assert_equal "https://housing.osu.edu/posts/images/morrill-tower-big.jpg", housing.image
		assert_equal "Columbus", housing.campus
		assert_equal "614-292-8205", housing.phone
		assert_equal facilities, housing.facility_set
		assert_equal "West", housing.area
		assert_equal "Jonathan Adams", housing.hall_director
		assert_equal "International House Learning Community", housing.learning_community
	end

	def test_housing_baker_hall_west
		agent = Mechanize.new
		parent_page = agent.get("https://housing.osu.edu/roomsearch/")
		building_page = agent.get("https://housing.osu.edu/roomsearch/baker-hall-west")
		housing = Housing.new(parent_page, building_page)
		facilities = ["Corridor Bath", "ResNet", "Bike Room Accessible", "Microwave/Refrigerator", "Laundry Facilities (in complex)", "Lounge space", "Handicap Access", "Vending Machines", "Single-gender rooms on single gender wings"]
		assert_equal "Baker Hall West", housing.name
		assert_equal "129 West 12th Avenue", housing.address
		assert_equal "129 West 12th Avenue, Columbus, OH 43210", housing.full_address
		assert_equal "https://housing.osu.edu/posts/images/bakerwest-big.jpg", housing.image
		assert_equal "Columbus", housing.campus
		assert_equal "614-292-6141", housing.phone
		assert_equal facilities, housing.facility_set
		assert_equal "South", housing.area
		assert_equal "Dan Schafer-Kuhlman", housing.hall_director
		assert_equal "Visual and Performing Arts Learning Community", housing.learning_community
	end

	def test_housing_veteran_house
		agent = Mechanize.new
		parent_page = agent.get("https://housing.osu.edu/roomsearch/")
		building_page = agent.get("https://housing.osu.edu/roomsearch/veterans-house")
		housing = Housing.new(parent_page, building_page)
		facilities = ["Corridor Bath", "Laundry Facilities (in complex)", "Game Room", "Air Conditioning", "On site parking", "Lounge space"]
		assert_equal "Veteran's House", housing.name
		assert_equal nil, housing.address
		assert_equal nil, housing.full_address
		assert_equal "https://housing.osu.edu/posts/images/vetshouse-big.jpg", housing.image
		assert_equal "n/a", housing.campus
		assert_equal "614-292-8266", housing.phone
		assert_equal facilities, housing.facility_set
		assert_equal "n/a", housing.area
		assert_equal "Jen Nelson", housing.hall_director
		assert_equal "No Learning Community", housing.learning_community
	end

	def test_housing_franklin_court
		agent = Mechanize.new
		parent_page = agent.get("https://housing.osu.edu/roomsearch/")
		building_page = agent.get("https://housing.osu.edu/roomsearch/franklin-court")
		housing = Housing.new(parent_page, building_page)
		facilities = ["Air Conditioning", "ResNet", "Academic Year Housing", "Microwave/Refrigerator", "Laundry Facilities (in complex)", "Own Trash Removal", "Kitchen Facilities"]
		assert_equal "Franklin Court", housing.name
		assert_equal "1901 Apple Orchard Drive", housing.address
		assert_equal "1901 Apple Orchard Drive, Wooster, OH 44691", housing.full_address
		assert_equal nil, housing.image
		assert_equal "Wooster/ATI", housing.campus
		assert_equal "(330) 287-7504", housing.phone
		assert_equal facilities, housing.facility_set
		assert_equal "n/a", housing.area
		assert_equal "Mick Steiner", housing.hall_director
		assert_equal "No Learning Community", housing.learning_community
	end

	def test_housing_molyet_village_apartments
		agent = Mechanize.new
		parent_page = agent.get("https://housing.osu.edu/roomsearch/")
		building_page = agent.get("https://housing.osu.edu/roomsearch/molyet-village-apartments")
		housing = Housing.new(parent_page, building_page)
		facilities = ["Suite/Room Bath", "Kitchen Facilities", "Academic Year Housing", "Air Conditioning", "ResNet", "Own Trash Removal", "Microwave/Refrigerator", "Laundry Facilities (in complex)"]
		assert_equal "Molyet Village Apartments", housing.name
		assert_equal "1365 Springmill Road", housing.address
		assert_equal "1365 Springmill Road, Mansfield, OH 44903", housing.full_address
		assert_equal nil, housing.image
		assert_equal "Mansfield", housing.campus
		assert_equal "(419) 747-8500", housing.phone
		assert_equal facilities, housing.facility_set
		assert_equal "n/a", housing.area
		assert_equal "Mike Schopieray", housing.hall_director
		assert_equal "No Learning Community", housing.learning_community
	end

	def test_housing_newark_apartments
		agent = Mechanize.new
		parent_page = agent.get("https://housing.osu.edu/roomsearch/")
		building_page = agent.get("https://housing.osu.edu/roomsearch/newark-apartments")
		housing = Housing.new(parent_page, building_page)
		facilities = ["Single-gender room/suite; Mixed gender wing/floor", "Kitchen Facilities", "Academic Year Housing", "Suite/Room Bath", "ResNet", "On site parking", "Air Conditioning", "Laundry Facilities (in complex)", "Own Trash Removal", "Microwave/Refrigerator"]
		assert_equal "Newark Apartments", housing.name
		assert_equal "929 Sharon Valley Road", housing.address
		assert_equal "929 Sharon Valley Road, Newark, OH 43055", housing.full_address
		assert_equal nil, housing.image
		assert_equal "Newark", housing.campus
		assert_equal "740-364-7700", housing.phone
		assert_equal facilities, housing.facility_set
		assert_equal "n/a", housing.area
		assert_equal "Joe McCartney", housing.hall_director
		assert_equal "No Learning Community", housing.learning_community
	end
end
