require_relative '../../config/environment.rb'
class SuperUser < Startup

#     # @superuserquote = ["With great power, comes great responsibility. Do not abuse your power, oh mighty #{@@user.name}"]

    @@prompt = TTY::Prompt.new



    def self.putsyellow(text)
        puts text.colorize(:yellow)
    end

    def self.putsgreen(text)
        puts text.colorize(:green)
    end

    def self.logged_in_menu
        puts "\e[H\e[2J"
        puts "***************************************************************************".colorize(:cyan)
        self.putsyellow( "▄████████  ▄█          ▄████████   ▄▄▄▄███▄▄▄▄   ▀█████████▄     ▄████████ ")
        sleep 0.05
        self.putsyellow( "███    ███ ███         ███    ███ ▄██▀▀▀███▀▀▀██▄   ███    ███   ███    ███ ")
        sleep 0.05
        self.putsyellow( "███    █▀  ███         ███    ███ ███   ███   ███   ███    ███   ███    ███ ")
        sleep 0.05
        self.putsyellow( "███        ███         ███    ███ ███   ███   ███  ▄███▄▄▄██▀   ▄███▄▄▄▄██▀ ")
        sleep 0.05
        self.putsyellow( "███        ███       ▀███████████ ███   ███   ███ ▀▀███▀▀▀██▄  ▀▀███▀▀▀▀▀   ")
        sleep 0.05
        self.putsyellow( "███    █▄  ███         ███    ███ ███   ███   ███   ███    ██▄ ▀███████████ ")
        sleep 0.05
        self.putsyellow( "███    ███ ███▌    ▄   ███    ███ ███   ███   ███   ███    ███   ███    ███ ")
        sleep 0.05
        self.putsyellow( "████████▀  █████▄▄██   ███    █▀   ▀█   ███   █▀  ▄█████████▀    ███    ███ ")
        sleep 0.05
        puts "*****************************************************************".colorize(:cyan) + "███    ███".colorize(:yellow)
        
        puts " "
        puts '         🏁   '
        puts '        ^\_ '
        puts '    o_/^   \ '
        puts '    /_^     `_ '
        puts '    \/^       \ '
        puts '    / ^         \ '
        puts '    ^             ` '
        puts " "
        # puts "Hi #{@@user.name}!".colorize(:cyan) 
        puts " "
        puts "Welcome to the Clambr admin dashboard".colorize(:cyan)
        puts "Here, you are god!".colorize(:cyan)
        puts "Remember, with great power, comes great responsibility. Do not abuse your power, oh mighty superuser"
        puts " "
        puts " "
        puts "HOME MENU".colorize(:cyan)
        choice = @@prompt.select("What would you like to do?".colorize(:cyan), "Update, ban or delete users", "View all users and sessions", "See usage stats", "Logout")
        case choice
            when "Update, ban or delete users"
                Superuser.update_account
            when "View all users, trainers & walls"
                Superuser.users_and_sessions_menu    
            when "See usage stats"
                Superuser.stats_menu
            when "Logout"
                Startup.home_menu
        end
    end

    def self.update_account
        puts "UPDATE ACCOUNT".colorize(:cyan)
        puts "Please enter the email address of user you would like to update"
        @user = gets.chomp
        choice = @@prompt.select("What would you like to change?".colorize(:cyan), "Name", "Grade", "Email", "Delete account", "Ban user".colorize(:red), "Return to home")
        case choice
        
        when "Name"
                puts "Please enter the new username for #{@user.name}.".colorize(:cyan)
                a = gets.chomp
                @user.update(name: a)
                puts " "
                puts "No problem, from now on they shall be known as".colorize(:cyan) + " #{@user.name}!".colorize(:green)
                puts " "
                Superuser.return_to_main

        when "Grade"
            puts "Ok superuser, time to abuse your power. Select the #{@user}'s new grade (<- ->)".colorize(:cyan)
            Superuser.grade_slider
                puts "User grade now set to V#{@user.grade}.".colorize(:green)
                sleep 2
            Superuser.return_to_main
        
        when "Email"
            puts "Please enter the new email address for #{@user.name}".colorize(:cyan)
            c = gets.chomp
            valid_email = Client.valid_email?(c)
            if valid_email
                @user.update(email: c)
                puts " "
                puts "Email address changed to #{@user.email} for #{@user.name}.".colorize(:cyan)
                puts " "
                sleep 5
                Superuser.return_to_main
            else
                puts " "
                choice = @@prompt.select("That's not a valid email address, please try again", "Start again")
                if choice == "Start again"
                    Superuser.update_account
                end
            end
        
        when "Delete account"
            puts "Are you sure you want to delete #{@user.name}'s account? Type DELETE to confirm.".colorize(:red)
            d = gets.chomp
            if d == "DELETE"
                Client.delete_account(@user.email)
                puts "Account Deleted!!"
                sleep 3
                Startup.home_menu
            else
                choice = @@prompt.select("Deletion cancelled! {@user.name} dodged a bullet there!".colorize(:red), "Return to main menu")
                if choice == "Return to main menu"
                    Superuser.logged_in_menu
                end
            end
            
        when "Ban user"
            puts "Please enter the email of the user you want to ban."
            puts "Banning a user will blacklist their email address."
            puts "This CANNOT be undone!".colorize(:red)
            email = gets.chomp
            Trainer.ban_client(email)
            puts "The user has been banished. Never to tread on Clambr soil again!"
        
        when "Return to home"
            Superuser.logged_in_menu
        end
    end

    def self.users_and_sessions_menu
        choice = @@prompt.select("", "User list", "Wall list", "Trainer list")
        case choice
        when "User list"
            puts Client.all(&:name)
        when "Wall list"
            Wall.all.each { |wall| puts "#{wall.name}: #{wall.location}, #{wall.area}" }
        when "Trainer list"
            puts Trainer.all(&:name)
        end
    end

    def self.area_selector
        puts " "
        choice = @@prompt.select("Which area of London looking for stats in?".colorize(:cyan), "North London", "East London", "South London", "West London", "All walls in all areas")
        self.wall_selector(choice)
    end

    def self.wall_selector(location)
        case location
        when "North London"
            @choice = @@prompt.select("Select a wall".colorize(:cyan), Wall.where(area: "North London").map(&:name))
        when "East London"
            @choice = @@prompt.select("Select a wall".colorize(:cyan), Wall.where(area: "East London").map(&:name))
        when "South London"
            @choice = @@prompt.select("Select a wall".colorize(:cyan), Wall.where(area: "South London").map(&:name))
        when "West London"
            @choice = @@prompt.select("Select a wall".colorize(:cyan), Wall.where(area: "West London").map(&:name))
        when "All walls in all areas"
            Superuser.global_stats
        end
    end

    def self.global_stats
        puts "Total Sessions: #{Session.all.length}"
        puts "Total users: #{Client.all.length}"
        puts "Total walls: #{Wall.all.length}"
        puts "Total trainers: #{Trainer.all.length}"
        puts "Total number of banned users: #{BannedUser.all.length}"
    end

    def self.return_to_main
        choice = @@prompt.select("", "Return to main menu", "Logout")
        if choice == "Return to main menu"
            Superuser.logged_in_menu
        else
            Startup.home_menu
        end
    end

    def self.continue_to_main
        choice = @@prompt.select("", "Continue to main menu", "Logout")
        if choice == "Continue to main menu"
            Superuser.logged_in_menu
        else
            Startup.home_menu
        end
    end

    def self.grade_slider
        choice = @@prompt.slider("",{min: 0, max: 10, step: 1})
        @user.update(grade: choice)
    end

end