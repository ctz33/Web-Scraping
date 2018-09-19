# Author: Ariel
# Created: 6/11
# Edit: N/A
#
require 'mechanize'

class Jobpost
	# initialize Housing class
	def initialize(parent_page,job_page)
		@parent_page = parent_page
		@job_page = job_page
		@jobname = parse_jobname()
		@description = parse_description()
  end

	def parse_jobname()
    return @job_page.search('.wrap-article-content h2').text.strip
	end

	def parse_description()
		return @job_page.search('.wrap-article-content div')[0].text.strip
	end

  def parse_info
    title_list=@job_page.search('.wrap-article-content dl dt').map{|x| x.text.gsub(/[\s]+/, " ").strip}
    info_list=@job_page.search('.wrap-article-content dl dd').map{|x| x.text.gsub(/[\s]+/, " ").strip}
    info=Hash[title_list.zip(info_list)]
    info.merge!("Job Name": @job_page.search('.wrap-article-content h2').text.gsub(/[\s]+/, " ").strip)
    info.merge!("Job Description": @job_page.search('.wrap-article-content div')[0].text.gsub(/[\s]+/, " ").strip)
    return info
  end
end
