# Author: Ariel
# Created: 6/11
# Edit: Gail 6/14 Add receive_email? and get_email
# Description: This module has functions related to sending an email with scraped data.
require 'pony'
module EmailUtils

  # Ask the user if he wants to receive email
  def receive_email?()
		puts "\nDo you want to receive scraped data via email:"
		want_email = gets.chomp.downcase
    return /^(y|Y).*/.match? want_email
	end

  # Get valid email address
  def get_email()
    email_regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    user_email = ""
    loop do
      puts "\nEnter your email address to receive scraped data:"
      user_email = gets.chomp
      break if email_regex.match? user_email
      puts "Sorry, it's an invalid email address."
    end
    return user_email
  end

  # Send a file to the given email address
  def send_email_by_passing_file(sendto, attachmnent_filename, path='./public')
    Pony.mail({
      :to => sendto,
      :from => 'Magic Team',
      :subject => 'Your web scrapper successfully finished',
      :body => 'Thanks for using web scrapper service offered by MAGiC',
      :attachments => {attachmnent_filename => File.read(File.join(path, attachmnent_filename))},
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'osu.magic.team@gmail.com',
        :password             => 'OSUCSE3901',
        :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
      },
    })
  end

  # Send a jsonobject to the given email address
  def send_email_by_passing_jsonobject(sendto, json_object, filename)
    Pony.mail({
      :to => sendto,
      :from => 'Magic Team',
      :subject => 'Your web scrapper successfully finished',
      :body => 'Thanks for using web scrapper service offered by MAGiC',
      :attachments => {filename => "json_object"},
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'osu.magic.team@gmail.com',
        :password             => 'OSUCSE3901',
        :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
      },
    })
  end

end
