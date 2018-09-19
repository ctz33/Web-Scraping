# Author: Ariel
# Created: 6/11
# Edit: Gail 6/12 Add documentation
# Edit: Channing 6/14 Added text searching to get_sub_page and comments
# Description: Creates a general web Scraper that can generate the page and subpages of a given website.

require 'mechanize'
require_relative './Jsonify'
require_relative './EmailUtils'

class WebScraper
  # include WebChoice
  include Jsonify
  include EmailUtils

  #Initialize a web scraper for the given web address
  def initialize(address)
    @agent = Mechanize.new
    @address = address
  end

  # Return a mechanize page from the given website
  def get_base_page()
    begin
      page = @agent.get @address
    rescue Mechanize::ResponseReadError => e
      page = e.force_parse
    end
  end

  # Generate a list of pages from all links on the base website that match the ref/text_pattern
  def get_sub_page(ref_pattern, text_pattern = '', base_page=get_base_page)
    if text_pattern == ''
      base_page.links_with(href: %r{^#{ref_pattern}\w+})
    else
      base_page.links_with(text: %r{#{text_pattern}}i, href: %r{#{ref_pattern}})
    end
  end

end
