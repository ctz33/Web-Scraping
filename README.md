# Project 3 - Web Scraping
### 1. [Overview](#overview)
### 2. [Instructions](#instructions)
### 3. [Roles](#roles)
### 4. [Contributions](#contributions)
### 5. [Meetings](#meetings)

***

### Overview
  This program scrapes data from [OSU Residence Hall](https://housing.osu.edu/roomsearch/), [OSU Sports](http://www.ohiostatebuckeyes.com/) and [OSU Student Job Board](https://sfa.osu.edu/jobs/job-board). The user can choose which website to scrape and the results for housing and sport scrapers will be shown in a webpage automatically. Attention: Firefox must be installed and the system must be linux for automatic display.

  Housing scraper gets information about residence halls' names, addresses, pictures, campus areas, phone numbers, facilities, hall directors and learning communities. The user can choose to get results via email.

  Sports scraper gets information about sports' names and gender, names of coaches and players, pictures of coaches and players, and previous game's stats. The user will be asked to choose which sport and which gender to scrape. Sports choices include baseball, basketball, football, lacrosse, soccer, tennis, and hockey. Gender choices include m and w corresponding to man and woman. Attention: There is no Women's baseball or Women's football.

  Student Job scraper gets information about the titles, descriptions and information of jobs posted on the student job board. The user will be asked to enter keywords and choose one or more locations to search jobs. If the user enters nothing for keywords, the scraper will gets all information that matches the chosen location(s). For the locations, the scraper is looking for keywords "on", "off" and "home". If user enters these keywords, the information corresponding "on campus", "off campus", and "work from home" will be filtered. The user will also be asked to enter the email address to get results via email.

  Performance Issue:Housing and sport scapers generally takes up to 1 minute to run.Job scraper depends largely on the searching scope and can take from 10 seconds to 2 minutes. Be patient. For scapers with browser opened, process will terminate when browser window is closed.
***

### Instructions
Before scraping the website, obtain some gems by following the steps below:
1. Enter the following command in the terminal to check if you already have Bundler installed:
```
 $ bundle -v
```
  If bundler were not already present, you would have to install it:
```
 $ gem install bundler --no-ri --no-rdoc
 $ rbenv rehash # bookkeeping required by rbenv
```
2. Install gems using Bundler:
```
 $ bundle install # installs gems and creates Gemfile.lock
 $ rbenv rehash # bookkeeping required by rbenv
```
</br>Run the program by entering the following code in the terminal:
```
  $ bundle exec ruby main.rb
```


***

### Roles
| Role|Team Member|
| ------------- |-------------|
| Overall Project Manager| Mike Lin |
|Coding Manager|Channing Jacobs|
|Testing Manager|Ariel Zhu|
|Documentation Manager| Gail Chen|

***

### Contributions
Mike:
* housingJS.js
* sportJS.js
* osu_housing_scraper.html
* osu_sport_scraper.html
* sportIndex.html
* style.css
* sportStyle.css

Channing:
* sports_scraper(1 of 3 scrapers)
* Sport class
* parse_learning_community in Housing class
* unit_testing_sport
* Gemfile

Ariel:
* student_employment_scraper (1 of 3 scrapers)
* Jobpost class
* WebScraper
* Jsonify
* EmailUtils
* unit_testing_job
* integration_testing_job

Gail:
* housing_scraper (1 of 3 scrapers)
* Housing class
* unit_testing_housing
* unit_testing_valid_choice
* WebChoice
* EmailUtils

***

### Meetings
* June 5th:
  * Group came up with the overall algorithm and structure
  * Group decided which website to scrape, what data to extract and how to display the data
* June 11th:
  * Mike: worked on displaying the data
  * Channing: worked on parse_learning_community and parse_room, started sports page parsing
  * Ariel: worked on sending email and main.rb
  * Gail: modified housing class and unit testing
* June 12th:
  * Mike and Gail: worked on displaying the data
  * Channing: worked on sports scraper
  * Ariel: worked on job scraper
* June 14th:
  * Channing: documented sport.rb, osu_sports.rb, tested osu_sports.rb, added text search to WebScrapper class, Gemfile updated to include used gems
  * Mike: made osu_sport_scrapper.html, sportIndex.html, sportJS.js and sportStyle.css
  * Ariel: updated and tested(both unit and intergration testing) student_employment_scraper
  * Gail: Wrote README, update main.rb
