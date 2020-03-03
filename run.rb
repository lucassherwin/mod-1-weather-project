require 'pry'
require_relative './config/environment'
require 'rest-client'
require 'json'

def login_user(name, age)
    user = User.find_or_create_by(name: name, age: age)
end

def log_location(name, woeid)
   location = Location.find_or_create_by(name: name, woeid: woeid) 
end

def run_application
    puts "Please enter your name:"
    name_input = gets.chomp
    
    puts "Please enter your age:"
    age_input = gets.chomp.to_i
    
    login_user(name_input, age_input)

    puts "Enter the name of a city to see the weather:"
    user_input = gets.chomp
    if user_input.match(/\s/)
        user_input.gsub!(/\s/,"%20")
    end 
    # user_input.gsub!(/\s/,"%20")
    unparsed_data = RestClient.get("https://www.metaweather.com/api/location/search/?query=#{user_input}")
    parsed_data = JSON.parse(unparsed_data)
    get_woeid = parsed_data[0]["woeid"]
    get_name = parsed_data[0]["title"]
    log_location(get_name, get_woeid)
end

run_application