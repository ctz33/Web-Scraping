=begin
	Author: Channing Jacobs
	Date created: 6/14
	Edit: N/A
	Test plan for testing Sport class:
	Data based off of website data from 6/14/18.
	Supported sports: baseball, basketball, football, ice hockey, lacrosse,
	soccer, and tennis. The 4 selected tests cover the range of differences
	that are seen between supported pages.

	1. Men's Baseball page
	2. Women's Basketball pages
	3. Men's Football page
	4. Women's Tennis pages
=end

require 'mechanize'
require "../osu_sports_scraper/sport"
require "test/unit"

class TestSport < Test::Unit::TestCase

	def test_baseball_men
		agent = Mechanize.new
		page = agent.get("http://www.ohiostatebuckeyes.com/sports/m-basebl/osu-m-basebl-body.html")
		baseball_men = Sport.new(page)

		assert_equal page, baseball_men.main_page
		assert_equal "Baseball", baseball_men.name
		assert_equal "Men's", baseball_men.gender

		coaches = ["Greg Beals", "Mike Stafford", "Chris Holick", "Dan DeLucia", "Matt Angle",
	   "Dean Hansen", "Blair Everhart", "Drew Onega", "Connor Oates", "Jack Young", "Connor Peters",
		 "Danny Matejczyk"]
		assert_equal coaches, baseball_men.coach_names

		players = ["Jacob Barnwell", "Dominic Canzone", "Matt Carpenter", "Brady Cherry", "Bo Coolen",
			"Tyler Cowles", "Connor Curlis", "Dillon Dingler", "Luke Duermit", "Ryan Feltner", "Andrew Fishel",
	    "Kobie Foppe", "Curtiss Irving", "Jonathan Jahn", "Malik Jones","Dustin Jourdan", "Seth Kinker",
	    "Seth Lonsway", "Andrew Magno", "Noah McGowan", "Kyle Michalik", "Adam Niemeyer", "Yianni Pavlopoulos",
	    "Conner Pohl", "Nate Romans", "Jake Ruby", "Scottie Seymour", "Griffan Smith", "Alex Theis", "Jake Vance",
	    "Thomas Waning", "Noah West", "Ridge Winand", "Austin Woodby"]
		assert_equal players, baseball_men.player_names

		coach_pics = ["http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/12231352.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/9426943.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/9426799.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/12231338.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/11719081.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/genrel/auto_headshot/8005014.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/12231335.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13061132.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/12231339.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/12231358.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044083.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044089.jpeg"]
			assert_equal coach_pics, baseball_men.coach_pictures

			player_pics = ["http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000796.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000804.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000785.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000805.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000828.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000810.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000811.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000813.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000778.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000814.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000816.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13000836.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002356.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002377.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002380.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002361.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002385.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002393.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002394.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002417.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002423.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002397.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13002424.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044138.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044147.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044155.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044146.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044156.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044157.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044163.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044166.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044167.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044206.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/m-basebl/auto_headshot/13044238.jpeg"]
			 assert_equal player_pics, baseball_men.player_pictures

			 stats = ["Jun 02, 2018", "Greenville, N.C.", "UNCW 4, Ohio State 3"]
			 assert_equal stats, baseball_men.prev_game
	end

	def test_basketball_women
		agent = Mechanize.new
		page = agent.get("http://www.ohiostatebuckeyes.com/sports/w-baskbl/osu-w-baskbl-body.html")
		basketball_women = Sport.new(page)

		assert_equal page, basketball_women.main_page
		assert_equal "Basketball", basketball_women.name
		assert_equal "Women's", basketball_women.gender

		coaches = ["Kevin McGuff", "Patrick Klein", "Mark Mitchell", "Carrie Banks",
	 		"Beth Howe", "Ericka Haney", "Chalisa Fonza", "Sydney Durrah", "Reid Guzdanski"]
		assert_equal coaches, basketball_women.coach_names

		players = ["Stephanie Mavunga", "Kelsey Mitchell", "Sierra Calhoun", "Chelsea Mitchell",
			"Savitha Jayaraman", "Karlie Cronin", "Linnae Harper", "Asia Doss", "Alexa Hart",
	   "Makayla Waterman", "Jensen Caretti"]
		assert_equal players, basketball_women.player_names

		coach_pics = ["http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/9166846.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/9166842.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/9166824.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/11997711.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/9166819.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/12883657.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/9166830.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/12883653.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/12883643.jpeg"]
		assert_equal coach_pics, basketball_women.coach_pictures

		player_pics = ["http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/13022294.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/13022275.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/13022267.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/13022295.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/12883688.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/12883666.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/13022273.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/13022272.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/13022274.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/13022276.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-baskbl/auto_headshot/13022288.jpeg"]
		assert_equal player_pics, basketball_women.player_pictures

		stats = ["Mar. 19, 2018", "Columbus, Ohio", "Central Michigan 95, Ohio State 78"]
		assert_equal stats, basketball_women.prev_game
	end

	def test_football_men
		agent = Mechanize.new
		page = agent.get("http://www.ohiostatebuckeyes.com/sports/m-footbl/osu-m-footbl-body.html")
		football_men = Sport.new(page)

		assert_equal page, football_men.main_page
		assert_equal "Football", football_men.name
		assert_equal "Men's", football_men.gender

		coaches = ["Urban Meyer", "Greg Schiano", "Kevin Wilson", "Tony Alford",
	   "Billy Davis", "Ryan Day", "Larry Johnson", "Zach Smith", "Alex Grinch",
	   "Greg Studrawa", "Taver Johnson", "Mickey Marotti", "Tim Hinton", "Matt Thurin",
	   "Louie Addazio", "Corey Dennis", "Brian Voltolini", "Ryan Stamper",
	   "Mark Pantoni"]
		assert_equal coaches, football_men.coach_names

		players = ["Johnnie Dixon", "Jeffrey Okudah", "J.K. Dobbins", "Chase Young",
	   "Jordan Fuller", "Baron Browning", "Kory Curtis", "Dwayne Haskins", "Kendall Sheffield",
	   "Jashon Cornell", "Binjimen Victor", "Joe Burrow", "Amir Riep", "Austin Mack",
		 "Matthew Baldwin", "Sevyn Banks",  "Tyreke Johnson", "K.J. Hill", "Isaiah Pryor",
	   "Wayne Davis", "Jaylen Harris", "Keandre Jones", "Jonathon Cooper", "Tate Martell",
	   "Dallas Gant", "Jake Metzer", "Darryl Sinclair", "Pete Werner", "Parris Campbell",
	   "Marcus Williamson", "De'Shawn White", "Jahsen Wint", "Shaun Wade", "Mike Weber",
	   "Brendon White", "Michael Blanton", "Antonio Williams", "Dominic DeMaccio", "Jeremiah Knight",
	   "Kevin Dever", "Demario McCall", "Tuf Borland", "Dante Booker", "Master Teague",
	   "Mitch Rossi", "Alex Backenstoe", "Derrick Malone", "Alex Beck", "Rashod Berry",
	   "Malik Harrison", "Hayden Jester", "Bradley Robinson", "Amari McMahon", "Damon Arnette",
	   "Justin Hilliard", "Tate Duarte", "Liam McCullough", "Nathan Brock", "Antwuan Jackson",
	   "Wyatt Davis", "Davon Hamilton", "Matthew Jones", "Malik Barrow", "Aaron Cox",
	   "Joshua Alabi", "Isaiah Prince", "Blake Pfenning", "Gavin Cupp", "Brandon Pahl",
	   "Kevin Woidke", "Phillip Thomas", "Malcolm Pridgeon", "Robert Landers", "Zaid Hamdan",
	   "Matthew Burrell", "Noah Donald", "Josh Myers", "Tommy Togiai", "Michael Jordan", "Max Wray",
	   "Thayer Munford", "Branden Bowen", "Demetrius Knox", "Brady Taylor", "C.J. Saunders",
	   "Jake Hausmann", "Garyn Prater", "Terry McLaurin", "Brock Davin", "Dre'Mont Jones",
	   "Ellijah Gardiner", "Luke Farrell", "Bryan Kristan", "Drue Chrisman", "Haskell Garrett",
	   "Blake Haubeil", "Sean Nuernberger", "Nick Bosa", "Jerron Cage"]
		assert_equal players, football_men.player_names

		coach_pics = ["http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/7215648.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/11608490.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12355578.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/11223731.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12359780.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12359755.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/11224138.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/7834376.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/13170590.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/11622853.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/13170627.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/7834373.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/7834372.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/11223716.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/headshots/Addazio_Louie.JPG",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12357524.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/11223736.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12725720.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/7834374.jpeg"]
		assert_equal coach_pics, football_men.coach_pictures

		player_pics = ["http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718914.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719078.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718915.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719147.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718922.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718901.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12746129.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719038.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719102.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718906.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719084.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718902.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719081.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719074.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719052.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12974223.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12014983.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718925.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719045.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718911.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719075.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12746116.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719119.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718904.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719122.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719148.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719114.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/11253133.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719120.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719127.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12746163.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719066.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718897.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718908.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12769321.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718884.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719065.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718896.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719037.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719054.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718891.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719041.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719067.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12726174.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718913.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12015432.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718887.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12770302.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718883.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719080.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719093.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718912.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719092.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719146.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719079.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719063.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718909.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718907.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719090.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719058.jpeg",
	   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719077.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718899.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719047.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719105.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719100.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719039.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12746087.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719076.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718900.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719055.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718936.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718921.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719068.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718910.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718937.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719050.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12719091.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718898.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/m-footbl/auto_headshot/12718903.jpeg"]
		assert_equal player_pics, football_men.player_pictures

		stats = ["Dec 29, 2017", "Arlington, Texas", "Ohio State 24, USC 7"]
		assert_equal stats, football_men.prev_game
	end

	def test_tennis_women
		agent = Mechanize.new
		page = agent.get("http://www.ohiostatebuckeyes.com/sports/w-tennis/osu-w-tennis-body.html")
		tennis_women = Sport.new(page)

		assert_equal page, tennis_women.main_page
		assert_equal "Tennis", tennis_women.name
		assert_equal "Women's", tennis_women.gender

		coaches = ["Ty Tucker", "Melissa Schaub", "Adam Cohen", "Sarah Taylor",
	   "Gabriella De Santis", "Carrie Smith", "Jeff Deibel"]
		assert_equal coaches, tennis_women.coach_names

		players = ["Andrea Ballinger", "Hannah Cseplo", "Emma DeCoste",
	   "Shiori Fukuda", "Mary Beth Hurley", "Anna Sanford", "Olivia Sneed",
	   "Maria Tyrina", "Danielle Wolf"]
		assert_equal players, tennis_women.player_names

		coach_pics = ["http://grfx.cstv.com/photos/schools/osu/sports/m-tennis/auto_headshot/6574134.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/8931104.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/10593826.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/10593946.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/12368292.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/10594008.jpeg",
	   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/6503806.jpeg"]
			assert_equal coach_pics, tennis_women.coach_pictures

			player_pics = ["http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/13091383.jpeg",
		   "http://grfx.cstv.com/schools/osu/graphics/mtt-logo.gif",
		   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/13091403.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/13091387.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/13091406.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/13091414.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/13091415.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/13091407.jpeg",
		   "http://grfx.cstv.com/photos/schools/osu/sports/w-tennis/auto_headshot/13091428.jpeg"]
			 assert_equal player_pics, tennis_women.player_pictures

			 stats = ["May 11, 2018", "Unlisted", "Clemson 4, Ohio State 1"]
			 assert_equal stats, tennis_women.prev_game
	end

end
