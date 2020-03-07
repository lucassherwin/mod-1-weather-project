def welcome_message
    spacing("- - - - - Welcome to Mod-1-Weathers - - - - -")
end

def login_user(name, identifier)
    user = User.find_or_create_by(name: name, identifier: identifier)
end

def log_location(name, woeid)
    location = Location.find_or_create_by(name: name, woeid: woeid) 
end

def create_weather_instance(user_id, location_id, city, weather_status, temp_c, temp_f, humidity)
    Weather.create(user_id: user_id, location_id: location_id, city: city, weather_status: weather_status, temp_c: temp_c, temp_f: temp_f, humidity: humidity)
end

def spacing(entry)
    puts " - - - - - - - - - - - - - - - - - - - - - - -"
    puts " - - - - - - - - - - - - - - - - - - - - - - -"
    puts " #{entry}"
    puts " - - - - - - - - - - - - - - - - - - - - - - -"
    puts " - - - - - - - - - - - - - - - - - - - - - - -"
end

def get_user
    spacing("Please enter your desired username:")
    name_input = gets.chomp
    if name_input == ""
        puts "Please enter a username."
        get_user
    
    else
    # if age_input != Integer
    #     # puts "Please enter age as an integer!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    #     age_input = gets.chomp
    # # else 
    identifier = get_identifier
        user = login_user(name_input, identifier) 
    end
    # end
    # id = user[:id]
end

def letters?(string)
    string.chars.any? { |char| ('a'..'z').include? char.downcase }
end

def get_identifier
    spacing("Please enter your desired identifier on your numberpad:")
    identifier_input = gets.chomp
    if letters?(identifier_input) == true
        puts "#{identifier_input} is not a valid entry."
        get_identifier
    else 
    identifier = identifier_input.to_i
    end
end


def get_city
    spacing("Enter the name of a city to see the weather:")
    user_input = gets.chomp.strip
    user_input_s = user_input.to_s
    if user_input_s == "" 
        puts "#{user_input} is not a valid entry." 
        puts "Please check your spelling and try again."
        get_city
    end
    if user_input.match(/\s/)
        user_input.gsub!(/\s/,"%20")
    else user_input
    end
end

def update_name(user)
    puts "Please put your new desired username"
    new_name = gets.chomp 
    user.name = new_name
end

def update_id(user)
    puts "Please put your new desired identifier on your numberpad"
    new_identifier = gets.chomp
    user.identifier = new_identifier
end

def get_history(user)
    history = Weather.select { |object| object.user_id == user.id}
    # binding.pry
    history.each do |object|
        puts "#{object.city} had a temperature of #{object.temp_f}F° and #{object.temp_c}C° and humidity of #{object.humidity} "
    end
end

def info(user)
    puts "Name: #{user.name}  |  Identifier: #{user.identifier}"
end

def quit_app
    spacing("Thank you for using Mod-1-Weathers. Good bye.")
    puts "Created by Joseph Cha, Lucas Sherwin, Diana Ponce."
end

def delete_last(user)
    find_user = Weather.select { |object| object.user_id == user.id}
    find_user.last.delete
end

def delete_all(user)
    Weather.where(user_id: user.id).delete_all
end


def run_application
    welcome_message
    user = get_user
    returning_weather(user)
    additional_commands
    user_input_additional_commands(user)
end