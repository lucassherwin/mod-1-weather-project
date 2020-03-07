def additional_commands
    puts "- - - - - - - - - - - - - - - - - - - -"
    puts "Additonal Commands:"
    puts "Type 'history' to see past locations. (Under development)"
    puts "Type 'new_search to add a new city to see the weather."
    puts "Type 'info' for Username & Identifier."
    puts "Type 'quit' to exit application."
end

def additional_commands_2
    puts "- - - - - - - - - - - - - - - - - - - -"
    puts "Type 'back' for previous list of available commands."
    puts "Type 'delete_last' to delete last search location."
    puts "Type 'delete_all' to delete all search history."
    puts "Type 'quit' to exit application."
end

def additional_commands_3 
    puts "Type 'new_username' to change your username."
    puts "Type 'new_id' to change your identifier"
    puts "Type 'back' for previous list of available commands."
end

def user_input_additional_commands(user)
    user_input = gets.chomp
    if user_input == "history"
        get_history(user)
        additional_commands_2
        user_input_additional_commands_2(user)
    elsif user_input == "new_search"
        returning_weather(user)
        additional_commands
        user_input_additional_commands(user)
    elsif user_input == "info"
        info(user)
        additional_commands_3
        user_input_additional_commands_3(user)
    elsif user_input == "quit"
       quit_app
    else
        spacing("You did not write a valid command. Please input valid command")
        user_input_additional_commands(user)
    end
end


def user_input_additional_commands_2(user)
    user_input = gets.chomp
    if user_input == "delete_last"
        delete_last(user)
        spacing("Last search has been deleted.")
        additional_commands
        user_input_additional_commands(user)
    elsif user_input == "delete_all"
        delete_all(user)
        spacing("All history has been deleted.")
        additional_commands
        user_input_additional_commands(user)
    elsif user_input == "back"
        additional_commands
        user_input_additional_commands(user)
    elsif user_input == "quit"
        quit_app
    else
        spacing("You did not write a valid command. Please input valid command")
        user_input_additional_commands(user)
    end
end

def user_input_additional_commands_3(user)
    user_input = gets.chomp
    if user_input == "new_username"
        update_name(user)
        additional_commands
        user_input_additional_commands(user)
    elsif user_input == "new_id"
        update_id(user)
        additional_commands
        user_input_additional_commands(user)
    elsif user_input == "back"
        additional_commands
        user_input_additional_commands(user)
    end
end