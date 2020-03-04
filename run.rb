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
def create_weather_instance(user_id, location_id, city, weather_status, temp_c, temp_f, humidity)
    Weather.create(user_id: user_id, location_id: location_id, city: city, weather_status: weather_status, temp_c: temp_c, temp_f: temp_f, humidity: humidity)
end

def get_user
    puts "Please enter your name:"
    name_input = gets.chomp
    
    puts "Please enter your age:"
    age_input = gets.chomp.to_i
    
    # if age_input != Integer
    #     # puts "Please enter age as an integer!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    #     age_input = gets.chomp
    # # else 
        user = login_user(name_input, age_input) 
    # end
    # id = user[:id]
end

def get_city
    puts "Enter the name of a city to see the weather:"
    user_input = gets.chomp
    if user_input.match(/\s/)
        user_input.gsub!(/\s/,"%20")
    end

    return user_input
end

def update_weather_status()
    
end

# def update_weather_status()
    
#     Weather.find_or_create_by()
# end
def get_history
    past_locations = []
    self.user_id == users.user_id
    Weather.map 
end



def run_application
    user = get_user
    # binding.pry
    
   
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
    temp_in_c = parsed_weather_data["consolidated_weather"][0]["the_temp"]
    temp_in_f = temp_in_c * (9/5) + 32
    current_humidity = parsed_weather_data["consolidated_weather"][0]["humidity"]
    user_id = user[:id]
    location_id = location[:id]
    weather_instance = create_weather_instance(user_id, location_id, city_name, get_weather_status, temp_in_c, temp_in_f, current_humidity)
    weather_status = weather_instance.weather_status
# binding.pry

    # weather_data_hash = {
    #     user_id: user[:id],
    #     location_id: location[:id],
    #     city: city_name,
    #     weather_status: get_weather_status,
    #     temp_c: temp_in_c,
    #     temp_f: temp_in_f,
    #     humidity: current_humidity
    # }
   
    puts "- - - - - - - - - - - - - - - - - - - -"
    puts "- - - Today's weather for #{city_name}  - - - "
    puts "- - Currently #{weather_status} in #{city_name} - - "
    puts "- It is currently #{temp_in_c}C° and #{temp_in_f}F°. -"
    puts "- - - The current humidity is #{current_humidity}. - - - "
    puts "- - - - - - - - - - - - - - - - - - - -"

    #additional commands
    #history = show search history
    #add_location = add new location -> rerun with new location
    #set_default = set default location

    puts "Additonal Commands:"
    puts "Type 'history' to see past locations"
    puts "Type 'add_location to add a new city to see the weather"
    puts "Type 'delete_last' to delete last search location"
    puts "Type 'delete_all' to delete all search history"
    user_input = gets.chomp
    if user_input == "history"
        show_history
    elsif user_input == "add_location"
        puts "Enter a city:"
        user_input = gets.chomp
        add_city(user_input)
    elsif user_input == "delete_last"
        delete_last
    elsif user_input == "delete_all"
        delete_all
    end
    binding.pry
end
    def delete_all
      Weather.where(user_id: user[:id]).delete_all
    end

run_application

 binding.pry

 puts "test"