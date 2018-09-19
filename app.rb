require 'sinatra'
require 'rubygems'


configure do
  # The app's configuration root directory
  # set :config_root, ENV["OOD_APP_CONFIG_ROOT"] || "/etc/ood/config/apps/systemstatus"
  # Default file paths
  set :root,  File.dirname(__FILE__)
  set :public_folder, settings.root+'/public'
  set :views, settings.root

end

get '/' do
  redirect '/osu_housing_scraper_result'
end

get '/osu_housing_scraper' do
  # send_file File.join(settings.public_folder, 'osu_housing_scraper.html')
  erb :'public/osu_housing_scraper', :layout => :'public/layout'
end

get '/osu_housing_json' do
  # send_file File.join(settings.public_folder, 'osu_housing_scraper.html')
  send_file File.join(settings.public_folder, 'dorm.json')
end


get '/osu_sports_scraper' do
  erb :'public/osu_sport_scraper', :layout => :'public/layout'
end

get '/run_housing_scraper' do
  puts "You will be redirect to /osu_housing_scraper_result after it finished"
  x = load( 'osu_sports_scraper/sports_scraper.rb' )
  puts "The page is loading housing scraper #{x}"
  redirect '/osu_housing_scraper_result'
end

get '/osu_sports_json' do
  send_file File.join(settings.public_folder, 'sport.json')
end

get '/schedule_student_job' do

end

get '/run_student_job_scraper' do

end

get '/osu_student_job_json' do
  send_file File.join(settings.public_folder, 'student_jobs.json')
end

get '/source_code' do
  redirect "https://github.com/cse3901-osu-2018su/MAG-C-Project-3-Ruby-Web-Scraping"
end
