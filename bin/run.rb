require_relative '../config/environment'


def home_menu
    prompt = TTY::Prompt.new
    choice = prompt.select("What would you like to do?", "Create new account", "Update my account details", "Book a session", "See my stats")
    case choice
        when "Create new account"
            sign_in
        when "Update my account details"
            update_details
        when "Book a session"     
            area_selector
        when "See my stats"
            stats_menu
    end
end

def area_selector
    puts"Which area of London are you in?"
    prompt = TTY::Prompt.new
    choice = prompt.select("North London", "East London", "South London", "West London")
    choice
end

def wall_selector


puts " "
puts " "
puts '        ^\_ '
puts '    o_/^   \ '
puts '    /_^     `_ '
puts '    \/^       \ '
puts '    / ^         \ '
puts '    ^             ` '
puts " "
puts "Welcome to Clambr. The climbing trainer."
puts " "
puts "Thought for the day: Training is like fighting a bear."
puts "You don't stop when you're tired, you stop when the bear's tired!"
puts " "
home_menu





