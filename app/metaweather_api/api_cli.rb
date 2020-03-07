



def returning_weather(user)
    city = get_city

    unparsed_data = RestClient.get("https://www.metaweather.com/api/location/search/?query=#{city}")

    if unparsed_data == "[]" 
        puts "Invalid entry, please check your spelling and try again."
        returning_weather(user)
    else

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
    user_id = user.id
    location_id = location[:id]
    weather_instance = create_weather_instance(user_id, location_id, city_name, get_weather_status, temp_in_c, temp_in_f, current_humidity)
    weather_instance 
# binding.pry

    puts "- - - - - - - - - - - - - - - - - - - -"
    puts "- - - Today's weather for #{city_name}  - - - "
    puts "- - Currently #{get_weather_status} in #{city_name} - - "
    puts "- - It is currently #{temp_in_c.round}C° and #{temp_in_f.round}F°. - -"
    puts "- - - The current humidity is #{current_humidity}. - - - "
    puts "- - - - - - - - - - - - - - - - - - - -"
    end
end