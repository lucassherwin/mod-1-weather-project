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

# def create_weather_instance(user_id, location_id, city, weather_status, temp_f=nil, temp_c=nil, humidity=nil)
    
#     weather = Weather.find_or_create_by(user_id: user_id, location_id: location_id, city: city, weather_status: weat)
# end
def create_weather_instance(user_id, location_id)
    Weather.find_or_create_by(user_id: user_id, location_id: location_id)
end

def get_user
    puts "Please enter your name:"
    name_input = gets.chomp
    
    puts "Please enter your age:"
    age_input = gets.chomp.to_i
    
    user1 = login_user(name_input, age_input)
    # user1[:id]
end

def get_city
    puts "Enter the name of a city to see the weather:"
    user_input = gets.chomp
    if user_input.match(/\s/)
        user_input.gsub!(/\s/,"%20")
    end
    return user_input
end

def update_weather_status(hash)
    hash.each {|key, value| self.send(("#{key}="), value)}
end

# def update_weather_status()
    
#     Weather.find_or_create_by()
# end

def run_application
    user = get_user
    city = get_city
    # binding.pry

    

    unparsed_data = RestClient.get("https://www.metaweather.com/api/location/search/?query=#{city}")
    parsed_data = JSON.parse(unparsed_data)
    get_woeid = parsed_data[0]["woeid"]
    city_name = parsed_data[0]["title"]
    
    location = log_location(city, get_woeid)


    unparsed_weather_data = RestClient.get("https://www.metaweather.com/api/location/#{get_woeid}")
    parsed_weather_data = JSON.parse(unparsed_weather_data)

    # binding.pry
    get_weather_status = parsed_weather_data["consolidated_weather"][0]["weather_state_name"]
    weather_instance = create_weather_instance(user, city)
    test = weather_instance.weather_status = get_weather_status

    binding.pry
    # weather_data_hash = {
    #     user_id: user[:id],
    #     location_id: location[:id],
    #     city: city_name,
    #     weather_status: get_weather_status
    #     # temp_f: 
    #     # temp_c: 
    #     # humidity:
    # }
    # test = update_weather_status(weather_data_hash)
    
    # binding.pry
end

run_application

# binding.pry

# puts "test"