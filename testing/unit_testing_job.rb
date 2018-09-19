=begin
	Author: Ariel Zhu
	Date created: 6/14
	Edit:
	Test plan for testing Housing class(take 3 variables: keyword, location and email):
	1. Get all job posts with empty location
	2. Get all job posts with location='on campus'
	3. Get all job posts with location='off campus'
	4. Get all job posts with location='work from home'
	5. Get all job posts with location='on campus off campus'
	6. Get all job posts with location='off campus on campus '
	7. Get all job posts with location='on campus work from home'
	8. Get all job posts with location='work from home on campus'
	9. Get all job posts with location='work from home off campus'
	10. Get all job posts with location='off campus work from home '
	11. Get all job posts with location='on campus off campus work from home'
	12. Get all job posts with location='on campus work from home off campus'
	13. Get all job posts with location='off campus on campus work from home '
	14. Get all job posts with location='off campus work from home on campus'
	15. Get all job posts with location='work from home off campus on campus'
	16. Get all job posts with location='work from home on campus off campus  '
	17. Get job posts with keyword = ''
	18. Get job posts with keyword = ' '
	19. Get job posts with keyword = 'computer'
	20. Get job posts with keyword = 'TECH'
	21. Get job posts with keyword = 'Student Incident Response Specialist'
=end

require 'mechanize'
require_relative "../lib/WebScraper.rb"
require_relative "../osu_student_job_scraper/Jobpost"
require "test/unit"

class TestJob < Test::Unit::TestCase
	# system ( "ruby osu_student_job_scraper/student_employment_scraper.rb '' '' '' ")
	def test_all_job
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		after_form_page=form.submit
		puts form
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 116, sub_pages.size
	end

	def test_on_campus_job
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		on_campus_checkbox=form.checkbox_with(:value=> 'On Campus')
		on_campus_checkbox.check
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 45, sub_pages.size
	end

	def test_off_campus_job
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		off_campus_checkbox=form.checkbox_with(:value=> 'Off Campus')
		off_campus_checkbox.check
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 68, sub_pages.size
	end

	def test_home_campus_job
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		work_from_home_checkbox=form.checkbox_with(:value=> 'Work From Home')
		work_from_home_checkbox.check
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 3, sub_pages.size
	end


	def test_on_off_campus_job
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		on_campus_checkbox=form.checkbox_with(:value=> 'On Campus')
		on_campus_checkbox.check
		off_campus_checkbox=form.checkbox_with(:value=> 'Off Campus')
		off_campus_checkbox.check
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 113, sub_pages.size
	end

	def test_off_on_campus_job
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		off_campus_checkbox=form.checkbox_with(:value=> 'Off Campus')
		off_campus_checkbox.check
		on_campus_checkbox=form.checkbox_with(:value=> 'On Campus')
		on_campus_checkbox.check
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 113, sub_pages.size
	end

	def test_on_home_campus_job
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		on_campus_checkbox=form.checkbox_with(:value=> 'On Campus')
		on_campus_checkbox.check
		work_from_home_checkbox=form.checkbox_with(:value=> 'Work From Home')
		work_from_home_checkbox.check
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 48, sub_pages.size
	end

	def test_off_home_campus_job
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		off_campus_checkbox=form.checkbox_with(:value=> 'Off Campus')
		off_campus_checkbox.check
		work_from_home_checkbox=form.checkbox_with(:value=> 'Work From Home')
		work_from_home_checkbox.check
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 71, sub_pages.size
	end

	def test_home_off_on_campus_job
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		work_from_home_checkbox=form.checkbox_with(:value=> 'Work From Home')
		work_from_home_checkbox.check
		off_campus_checkbox=form.checkbox_with(:value=> 'Off Campus')
		off_campus_checkbox.check
		on_campus_checkbox=form.checkbox_with(:value=> 'On Campus')
		on_campus_checkbox.check
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 116, sub_pages.size
	end

	def test_empty_keyword
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 116, sub_pages.size
	end

	def test_empty_keyword_2
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		form["search"] = ' '
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		assert_equal 0, sub_pages.size
	end

	def test_keyword_computer
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		jobpost=[]
		payload=[]
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		form["search"] = 'computer'
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		sub_pages.each do |link|
			jobpost.push(Jobpost.new(base_page, link.click))
		end
		jobpost.each do |post|
		  payload.push(post.parse_info)
		end
		scraper.generate_json_file(payload, "test_keyword_computer_actual.json",path='test_job/')
		assert_equal 14, sub_pages.size
		assert_true FileUtils.compare_file('test_job/test_keyword_computer_expect.json', 'test_job/test_keyword_computer_actual.json')
	end

	def test_keyword_student_incident_response_specialist
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		jobpost=[]
		payload=[]
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		form["search"] = 'Student Incident Response Specialist'
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		sub_pages.each do |link|
			jobpost.push(Jobpost.new(base_page, link.click))
		end
		jobpost.each do |post|
			payload.push(post.parse_info)
		end
		scraper.generate_json_file(payload, "test_keyword_student_incident_response_specialist_actual.json",path='test_job/')
		assert_equal 1, sub_pages.size
		assert_true FileUtils.compare_file('test_job/test_keyword_student_incident_response_specialist_expect.json', 'test_job/test_keyword_student_incident_response_specialist_actual.json')
	end

	def test_keyword_tech
		scraper = WebScraper.new("https://sfa.osu.edu/jobs/job-board")
		jobpost=[]
		payload=[]
		#get base page object
		base_page = scraper.get_base_page
		form = base_page.form_with(:action => '/jobs/job-board')
		form["search"] = 'tech'
		after_form_page=form.submit
		sub_pages = scraper.get_sub_page("job-result/",'',after_form_page)
		sub_pages.each do |link|
			jobpost.push(Jobpost.new(base_page, link.click))
		end
		jobpost.each do |post|
		  payload.push(post.parse_info)
		end
		scraper.generate_json_file(payload, "test_keyword_tech_actual.json",path='test_job/')
		assert_equal 17, sub_pages.size
		assert_true FileUtils.compare_file('test_job/test_keyword_tech_expect.json', 'test_job/test_keyword_tech_actual.json')
	end

end
