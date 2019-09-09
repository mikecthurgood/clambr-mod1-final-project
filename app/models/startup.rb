class Startup < ActiveRecord::Base


def self.home_menu
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

def self.area_selector
    puts"Ok!"
    prompt = TTY::Prompt.new
    choice = prompt.select("Which area of London are you in", "North London", "East London", "South London", "West London")
    choice
end

    # north_london_walls = Wall.find_by_area("North London")
    # east_london_walls = Wall.find_by_area("East London")
    # south_london_walls = Wall.find_by_area("South London")
    # west_london_walls = Wall.find_by_area("West London")

    def self.wall_names(walls)
        walls.each do |wall|
            puts "#{wall.name}, #{wall.location}"
        end

    end 



def self.wall_selector(location)
    case location
    when "North London"
        # north_london_walls
        a = Startup.wall_names(Wall.find_by_area("North London"))
        puts a
    when "East London"
        east_london_walls
    when "South London"
        south_london_walls
    when "West London"
        west_london_walls
    end
end




end