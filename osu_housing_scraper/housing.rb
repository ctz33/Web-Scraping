=begin
	Author: Gail Chen
	Create Date: 6/6
	Edit: Gail 6/10 Better implementation of parse_address(), add variable @campus
	Edit: Gail 6/11 Add variable @image, use mechanize to parse elements instead of Nokogiri
	Edit: Mike 6/11 Repair parse_address and parse_campus
	Edit: Channing 6/11 Added LC data parsing and modified name parser
	Edit: Gail 6/11 Modify parse_name
	Edit: Gail 6/12 Modify parse_area, add variable @full_address and documentation
	Edit: Channing 6/14 Made parsing private
	Description:
		This Housing class is used to get and store data of each building from the website.
		Each parsing method gets its corresponding information from the website.
=end
require 'mechanize'

class Housing
	# initialize Housing class
	def initialize(parent_page, building_page)
		@parent_page = parent_page
		@building_page = building_page
		@name = parse_name
		@image = parse_image
		@address = parse_address
		@full_address = parse_full_address
		@campus = parse_campus
		@phone = parse_phone
		@facility_set = parse_facility_set
		@area = parse_area
		@hall_director = parse_hall_director
		@learning_community = parse_learning_community
	end
	# get instance variables
	attr_reader :parent_page
	attr_reader :building_page
	attr_accessor :name
	attr_accessor :image
	attr_accessor :address
	attr_accessor :full_address
	attr_accessor :campus
	attr_accessor :phone
	attr_accessor :facility_set
	attr_accessor :area
	attr_accessor :hall_director
	attr_accessor :learning_community

	# Generate a hash for importing it to json file
	def generate_hash()
		{
			name: @name,
			image: @image,
			address: @address,
			full_address: @full_address,
			campus: @campus,
			phone: @phone,
			facility_set: @facility_set,
			area: @area,
			hall_director: @hall_director,
			learning_community: @learning_community
		}
	end

	# Parsing should be private, no user calls
	private

	def parse_name()
		name = @building_page.search('#room-search-main h2').text.strip
		if name[-22] == "("
			return name[0..-24]
		end
		return name
	end

	# Get the picture of the residence hall
	def parse_image()
		base = "https://housing.osu.edu"
		src = @building_page.at('.image img')
		if src != nil
			return base + src.attr('src').to_s
		end
		return nil
	end

	# Get the address of the residence hall
	def parse_address()
		address = @building_page.at('#address-wrapper')
		if address != nil
			return address.to_s[/<\/h3>[.\W]*.*<br>/][/\d\d.*</][0..-2]
		end
		return nil
	end

	# Get full address of the residence hall for google map displaying
	def parse_full_address()
		address = @building_page.at('#address-wrapper')
		if address != nil
			return address.to_s[/<\/h3>[.\W]*.*<br>/][/\d\d.*</][0..-2] + ", " + address.to_s[/<br>.*/][4..-2]
		end
		return nil
	end

	# Get the campus that the residence hall locates
	def parse_campus()
		campus = @building_page.at('#address-wrapper')
		if campus != nil
			campus = campus.to_s[/<br>.*/][4..-2]
		end
		case campus
		when "Columbus, OH 43210"
			return "Columbus"
		when "Wooster, OH 44691"
			return "Wooster/ATI"
		when "Mansfield, OH 44903"
			return "Mansfield"
		when "Newark, OH 43055"
			return "Newark"
		else
			return "n/a"
		end
	end

	# Get the phone number of the residence hall
	def parse_phone()
		return @building_page.search('.contact-list .val')[0].text.strip
	end

	# Get an array of facilities that the residence hall has
	def parse_facility_set()
		amenties = []
		table = @building_page.search('.amenity-list td')
		table.each do |td|
			if (td.text.strip != "")
				amenties.push(td.text.strip)
			end
		end
		return amenties
	end

	# Get the area that the residence locates
	def parse_area()
		building = @parent_page.search('tr')
		building.each do |tr|
			if tr.search('td:nth-child(1) a').text.include?(@name)
				return tr.search('td:nth-child(4)').text.strip
			end
		end
		return "n/a"
	end

	# Get the hall director
	def parse_hall_director()
		return @building_page.search('.contact-list .val')[2].text.strip
	end

	# Get the learning community that the residence hall has
	def parse_learning_community()
		agent = Mechanize.new
		lc_main_page = agent.get("https://housing.osu.edu/learning-communities/")
		lc_links = lc_main_page.links_with(href: %r{.*/learningcommunities/\w+})
		lc_links.each {|link| (return link.to_s) if link.click.search('.icon-other a').text.match?(/#{@name}/i)}
		return "No Learning Community"
	end

end
