# Author: Channing Jacobs
# Date: 6/11/18
# Editor: N/A
# Sport object created by parsing osu sports page

require 'mechanize'

class Sport

    attr_reader :main_page
    attr_reader :name
    attr_reader :gender
    attr_reader :coach_names
    attr_reader :player_names
    attr_reader :player_pictures
    attr_reader :coach_pictures
    attr_reader :prev_game

  def initialize(page)
    @main_page = page
    @name = parse_name
    @gender = parse_gender
    @coach_names = parse_coach_names
    @player_names = parse_player_names
    @player_pictures = parse_player_pics
    @coach_pictures = parse_coach_pics
    @prev_game = parse_prev_game
  end

  def generate_hash
    {
      url: @main_page.uri.to_s,
      name: @name,
      gender: @gender,
      coach_names: @coach_names,
      player_names: @player_names,
      coach_pictures: @coach_pictures,
      player_pictures: @player_pictures,
      prev_game: @prev_game
    }
  end

  # Parsing calls should be done at initialization, not by user
  private

  def parse_name
    # Find name of sport (string)
    raw_name_arr = @main_page.search('div#sport-nav h3 a').text.chomp.split
    case raw_name_arr.size
    when 2
      return raw_name_arr[0].to_s
    when 3
      return raw_name_arr[1].to_s
    when 4
      return (raw_name_arr[1] + " " + raw_name_arr[2]).to_s
    else
      Kernel.abort("Error processing sport name.")
    end
  end

  def parse_gender
    # Find if sport is Men's or Women's (string)
    raw_name_arr = @main_page.search('div#sport-nav h3 a').text.chomp.split
    case raw_name_arr.size
    when 2
      return "Men's"
    when 3,4
      return raw_name_arr[0].to_s
    else
      Kernel.abort("Error processing sport gender.")
    end
  end

  def parse_prev_game
    # returning stats of last game as: [date, location, teams and scores]
    stat_page = @main_page.link_with(text: "Stats", href: %r"/sports/#{@main_page.uri.to_s.split('/')[4]}/").click
    # Stat pages have differing HTML links and text (years due to seasonal sports)
    year = Time.now.year
    if @gender == "Women's" && @name == "Basketball"
      season_page = Mechanize.new.get('http://www.ohiostatebuckeyes.com/sports/w-baskbl/sched/osu-w-baskbl-sched.html')
    elsif @name != "Football"
      season_page = stat_page.link_with(text: %r"(#{year}|#{year - 1}(-#{year.to_s[-2,2]})?)\s(Stats|Season)").click
    elsif @name == "Football"
      season_home = stat_page.link_with(text: %r"(#{year}|#{year - 1}(-#{year.to_s[-2,2]})?)\s(Stats|Season)", href: %r"/(#{year}|#{year - 1})-season.html").click
      season_page = season_home.link_with(text: "Season Stats (.html)").click
    end

    # Women's basketball and tennis have different HTML formals for finding scores
    if @gender == "Women's" && @name == "Basketball"
      raw_date = season_page.search('table#schedtable td.sch-col-1').last.text.strip
      prev_date = raw_date.slice(/\s[[:upper:]].*/).strip + ", "
      # Using month to calculate the year the match was held
      case prev_date.slice(/[[:upper:]]/)
      when 'O','N','D'
        prev_date += (Time.now.year - 1).to_s
      when 'J','F','M'
        prev_date += Time.now.year.to_s
      end
      # Location of match
      prev_loc = season_page.search('table#schedtable td.sch-col-3').last.text.strip
      # Home score location depends on a win or loss
      raw_score = season_page.search('table#schedtable td.sch-col-4').last.text.strip
      if raw_score[0] == "W"
      osu_points = raw_score.scan(/\d+/)[0]
      opp_points = raw_score.scan(/\d+/)[1]
    elsif raw_score[0] == "L"
      osu_points = raw_score.scan(/\d+/)[1]
      opp_points = raw_score.scan(/\d+/)[0]
      end
      # Combine data into the teams and score (3rd part of array returned)
      raw_opp_name = season_page.search('table#schedtable td.sch-col-2').last.text.strip
      opp_name = raw_opp_name.scan(/[[:upper:]]{1}.*/)[0]
      prev_res = opp_name + " " + opp_points + ", " + "Ohio State " + osu_points

    elsif @name == "Tennis"
      prev_data = season_page.search('table td font')
      prev_date = prev_data[4].text.strip
      # Location not provided by tennis pages
      prev_loc = "Unlisted"
      prev_res = prev_data[5].text.strip

    else
      prev_data = season_page.search('table td font')
      prev_date = prev_data[4].text.strip

      prev_loc = prev_data[5].text.strip

      prev_res = prev_data[6].text.strip

    end
    # Array with unicode and ascii leading and trailing spaces removed
    [prev_date.gsub(/[[:space:]]/, ' ').strip, prev_loc.gsub(/[[:space:]]/, ' ').strip, prev_res.gsub(/[[:space:]]/, ' ').strip]
  end

  def parse_player_names
    # Find player names in page
    roster_page = @main_page.link_with(text: "Roster", href: %r"/sports/#{@main_page.uri.to_s.split('/')[4]}/").click
    players = roster_page.search('#sortable_roster .player-row a')
    player_list = players.map {|player| player.text.strip}
    # Handle case of Last, First and convert to => "First Last"
    for name in player_list
      if name.include? ', '
        first_name = name.slice(name.index(', ') + 2, name.size - (name.index(', ') + 2))
        last_name = name.slice(/\w+, /).chop.chop
        player_list[player_list.index(name)] = first_name + " " + last_name
      end
    end
    return player_list
  end

  def parse_coach_names
    # Find all coach names in page
    roster_page = @main_page.link_with(text: "Roster", href: %r"/sports/#{@main_page.uri.to_s.split('/')[4]}/").click
    coaches = roster_page.search('#sortable_roster + table .player-row a')
    coaches.map {|coach| coach.text.strip}
  end

  def parse_player_pics
    # Find all images of players using roster page
    player_pic_links = []
    roster_page = @main_page.link_with(text: "Roster", href: %r"/sports/#{@main_page.uri.to_s.split('/')[4]}/").click
    for player in @player_names
      player_page = roster_page.link_with(text: /#{player}|#{player.split.last + ", " + player.split.first}/).click
      player_pic = player_page.search(%Q!img[alt^="#{player.split.first}"]!).attr('src').text
      player_pic_links << player_pic
    end
    return player_pic_links
  end

  def parse_coach_pics
    # Find all pictures of coaches starting at roster page
    coach_pic_links = []
    roster_page = @main_page.link_with(text: "Roster", href: %r"/sports/#{@main_page.uri.to_s.split('/')[4]}/").click
    for coach in @coach_names
      coach_page = roster_page.link_with(text: "#{coach}").click
      coach_pic = coach_page.search(%Q!img[alt^="#{coach.split.first}"]!).attr('src').text
      coach_pic_links << coach_pic
    end
    return coach_pic_links
  end

end
