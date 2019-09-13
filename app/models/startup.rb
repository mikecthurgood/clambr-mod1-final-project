require_relative '../../config/environment.rb'
class Startup

    @quote = ["Training is like fighting a bear. You don't stop when you're tired, you stop when the bear's tired!", "There are no shortcuts to any place worth going.", "You cannot teach a man anything. You can only help him discover it within himself.", "I don’t count my situps. I only start counting once it starts hurting. -Muhammad Ali", "I’ve failed over and over again in my life. And that is why I succeed.” – Michael Jordan", "There may be people that have more talent than you, but there’s no excuse for anyone to work harder than you do. – Derek Jeter", "To uncover your true potential you must first find your own limits and then you have to have the courage to blow past them.", "You miss 100 percent of the shots you don’t take.", "Never say never because limits, like fears, are often just an illusion."]

    @@user = nil

    def self.home_menu
        @@user = nil
        prompt = TTY::Prompt.new
        puts "\e[H\e[2J"
        puts "*************************************************".colorize(:cyan)
        putsyellow( "▄█        ▄██████▄     ▄██████▄   ▄█   ███▄▄▄▄    ")
        putsyellow( "███       ███    ███   ███    ███ ███  ███▀▀▀██▄ ")
        putsyellow( "███       ███    ███   ███    █▀  ███▌ ███   ███ ")
        putsyellow( "███       ███    ███  ▄███        ███▌ ███   ███ ")
        putsyellow( "███       ███    ███ ▀▀███ ████▄  ███▌ ███   ███ ")
        putsyellow( "███       ███    ███   ███    ███ ███  ███   ███ ")
        putsyellow( "███▌    ▄ ███    ███   ███    ███ ███  ███   ███ ")
        putsyellow( "█████▄▄██  ▀██████▀    ████████▀  █▀    ▀█   █▀  ")
        puts "*************************************************".colorize(:cyan)
        puts " "
        choice = prompt.select("What would you like to do?".colorize(:cyan), "Create new account", "Login")
        case choice
            when "Create new account"
                Startup.create_new_account
                Startup.continue_to_main
            when "Login"
                Startup.user_login
        end
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
        puts "Hi #{@@user.name}!".colorize(:cyan) 
        puts " "
        puts "Welcome to Clambr.".colorize(:cyan)
        puts "The climbing trainer.".colorize(:cyan)
        puts " "
        puts "Thought for the day:"
        puts @quote.sample
        puts " "
        prompt = TTY::Prompt.new
        puts "HOME MENU".colorize(:cyan)
        choice = prompt.select("What would you like to do?".colorize(:cyan), "Update or delete my account", "Book a session", "Cancel recently booked session", "See my stats", "Logout")
        case choice
            when "Update or delete my account"
                Startup.update_account
            when "Book a session"
                Startup.book_session  
            when "Cancel recently booked session"
                Startup.cancel_last_booked_session  
            when "See my stats"
                Startup.stats_menu
            when "Logout"
                Startup.home_menu
        end
    end

    def self.update_account
        prompt = TTY::Prompt.new
        puts "UPDATE ACCOUNT".colorize(:cyan)
        choice = prompt.select("What would you like to change?".colorize(:cyan), "Name", "Grade", "Email", "Change my password", "Delete my account".colorize(:red), "Return to home")
        case choice
        
        when "Name"
            Startup.change_name
        when "Grade"
            Startup.change_grade
        when "Email"
            Startup.change_email
        when "Change my password"
            Startup.password_change
        when "Delete my account".colorize(:red)
            Startup.delete_account
        when "Return to home"
            Startup.logged_in_menu
        end
    end

    def self.stats_menu
        num_sesh = @@user.number_of_sessions?
        w = @@user.which_walls?
        t = @@user.which_trainers?
        gra = @@user.grade
        puts "Hi #{@@user.name}. Here's your current Clambr stats:".colorize(:cyan)
        if num_sesh == 1
            puts "- You have had #{num_sesh} session!"
        else
            puts "- You have had #{num_sesh} sessions!"
        end
        puts "- You have climbed at #{w.join(", ")}."
        puts "- You have trained with #{t.join(", ")}"
        puts "- Your current grade is V#{gra}"
        sleep 2
        prompt = TTY::Prompt.new
        Startup.return_to_main
    end

    def self.book_session
        a = Startup.area_selector
        b = Startup.date_selector
        j = Wall.find_by(name: a)
        c = Client.find_by(email: @@user.email)
        if c
            d = Session.create(client_id: c.id, trainer_id: rand(1..20), wall_id: j.id, slot: b)
            spinner = TTY::Spinner.new("[:spinner] Please wait - booking your session.".colorize(:yellow), format: :bouncing_ball)
                20.times do
                spinner.spin
                sleep(0.1)
                end
            puts "\nThat session's all booked for you #{c.name}. \nYou'll be climbing on" + " #{b[:day]} #{b[:time]}".colorize(:cyan) + " with" + " #{d.trainer.name}".colorize(:yellow) +  " at" + " #{d.wall.name}.".colorize(:green) + " See you there! 🧗‍♀️ 🧗‍♂️ 💪"
            sleep 1
            Startup.return_to_main
        end
    end

    #book session helper functions

    def self.area_selector
        puts"Ok!".colorize(:cyan)
        prompt = TTY::Prompt.new
        choice = prompt.select("Which area of London are you in".colorize(:cyan), "North London", "East London", "South London", "West London")
        self.wall_selector(choice)
    end

    def self.wall_selector(location)
        case location
        when "North London"
            prompt = TTY::Prompt.new
            @choice = prompt.select("Which wall would you like to book a session at?".colorize(:cyan), Wall.where(area: "North London").map(&:name))
        when "East London"
            prompt = TTY::Prompt.new
            @choice = prompt.select("Which wall would you like to book a session at?".colorize(:cyan), Wall.where(area: "East London").map(&:name))
        when "South London"
            prompt = TTY::Prompt.new
            @choice = prompt.select("Which wall would you like to book a session at?".colorize(:cyan), Wall.where(area: "South London").map(&:name))
        when "West London"
            prompt = TTY::Prompt.new
            @choice = prompt.select("Which wall would you like to book a session at?".colorize(:cyan), Wall.where(area: "West London").map(&:name))
        end
    end

    def self.date_selector
        prompt = TTY::Prompt.new
        choice1 = prompt.select("What day would you like to choose?".colorize(:cyan), "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
        choice2 = prompt.select("Morning or afternoon?".colorize(:cyan), "Morning", "Afternoon")
        slot = {day: choice1, time: choice2, key: nil}
        case choice1
        when "Monday"
            if choice2 == "Morning"
                slot[:key] = 1
            else
                slot[:key] = 2
            end
        when "Tuesday"
            if choice2 == "Morning"
                slot[:key] = 3
            else
                slot[:key] = 4
            end
        when "Wednesday"
            if choice2 == "Morning"
                slot[:key] = 5
            else
                slot[:key] = 6
            end
        when "Thursday"
            if choice2 == "Morning"
                slot[:key] = 7
            else
                slot[:key] = 8
            end
        when "Friday"
            if choice2 == "Morning"
                slot[:key] = 9
            else
                slot[:key] = 10
            end
        when "Saturday"
            if choice2 == "Morning"
                slot[:key] = 11
            else
                slot[:key] = 12
            end
        when "Sunday"
            if choice2 == "Morning"
                slot[:key] = 13
            else
                slot[:key] = 14
            end
        end
        slot
    end

    #home menu helper functions
    def self.user_login
        @@user = Startup.account_finder
        if @@user.superuser == true
                SuperUser.logged_in_menu
        else 
                Startup.logged_in_menu
        end
    end
    
    def self.account_finder
        puts "Please input the email address associated with your account.".colorize(:cyan)
        email = gets.chomp
        puts "Please enter the password associated with that email.".colorize(:cyan)
        password = STDIN.noecho(&:gets).chomp
        a = Client.find_by(email: email, password: password)
        if !a 
            puts "Login failed - please try again or return to main menu"
            sleep 1
            prompt = TTY::Prompt.new
            choice = prompt.select("", "Try again", "Return to main menu")
            case
            when "Try again"
                Startup.account_finder
            when "Return to main menu"
                Startup.logged_in_menu
            end

        else
            a
        end
    end

    def self.create_new_account
        puts "What's your name?".colorize(:cyan)
            a = gets.chomp
        puts "What grade do you climb at? (1 - 10)?".colorize(:cyan)
            prompt = TTY::Prompt.new
            b = prompt.slider("Select your grade",{min: 0, max: 10, step: 1})
        puts "what's your email address?".colorize(:cyan)
            c = gets.chomp
        puts "Please choose a secure password. Or insecure, nobody cares enough to hack you <3".colorize(:cyan)
            d = STDIN.noecho(&:gets).chomp
            if Client.valid_email?(c)
                @@user = Client.create_user(a, b, c, d)
                puts "Thanks #{@@user.name}. Just to confirm, you climb at grade V#{@@user.grade} and we'll contact you on #{@@user.email}!"
                puts " "
                puts " "
                sleep 1
            else
                puts "Email invalid, please try again".colorize(:red)
                sleep 1
                prompt = TTY::Prompt.new
                choice = prompt.select("", "Try again", "Logout")
                    if choice == "Try again"
                        Startup.create_new_account
                    else
                        Startup.home_menu
                    end
            end
    end

    def self.retrieve_trainer_name_from_session(session)
        a = Trainer.find_by(id: session.trainer_id)
        b = a.name.colorize(:cyan)
        # binding.pry
    end

    def self.retrieve_wall_name_from_session(session)
        a = Wall.find_by(id: session.wall_id)
        b = a.name.colorize(:cyan)
    end

    def self.cancel_last_booked_session
        a = Session.where(client_id: @@user.id).last
        if a
            a.delete
            puts "We've" + " cancelled".colorize(:red) + " your booking with #{Startup.retrieve_trainer_name_from_session(a)} at #{Startup.retrieve_wall_name_from_session(a)}, #{@@user.name}."
            Startup.return_to_main
        else 
            puts "You've no sessions to cancel!".colorize(:cyan)
            sleep 2
            prompt = TTY::Prompt.new
            choice = prompt.select("Book a session, or return to main menu?".colorize(:cyan), "Book a session", "Return to main menu")
            case choice 

            when "Book a session"
                puts "OK!"
                sleep 1
                Startup.book_session
            when "Return to main menu"
                puts "OK!"
                sleep 1
                Startup.logged_in_menu
            end
    
        end
    end

    #update menu helper functions
    def self.change_name
        puts "Hi".colorize(:cyan) + " #{@@user.name},".colorize(:green) + " please enter your new username.".colorize(:cyan)
            a = gets.chomp
            @@user.update(name: a)
            puts " "
            puts "No problem, from now on you shall be known as".colorize(:cyan) + " #{@@user.name}!".colorize(:green)
            puts " "
            Startup.return_to_main
    end

    def self.change_grade
        puts "Hi #{@@user.name}, please select your new grade (<- ->)".colorize(:cyan)
        Startup.grade_slider
        if @@user.grade > 5    
            puts " "
            puts "Climbing at V#{@@user.grade}! You're" + " crushing it!".colorize(:green)
        else
            puts " "
            puts "Climbing at V#{@@user.grade}!" + " Keep pushing!".colorize(:red)
            sleep 2
        end
        Startup.return_to_main
    end

    def self.grade_slider
        prompt = TTY::Prompt.new
        choice = prompt.slider("".colorize(:cyan),{min: 0, max: 10, step: 1})
        @@user.update(grade: choice)
    end

    def self.change_email
        puts "Hi #{@@user.name}, please enter your new email address".colorize(:cyan)
        b = gets.chomp
        valid_email = Client.valid_email?(b)
        if valid_email
            @@user.update(email: b)
            puts " "
            puts "Great! We'll use #{@@user.email} for your login email!".colorize(:cyan)
            puts " "
            sleep 2
            Startup.return_to_main
        else
            puts " "
            prompt = TTY::Prompt.new
            choice = prompt.select("That's not a valid email address", "Try again", "Return to update my account menu")
            if choice == "Return to main menu"
                Startup.update_account
            else
                Startup.change_email
            end
        end        
    end
    
    def self.password_change
        puts "Please enter existing password"
        c = STDIN.noecho(&:gets).chomp
        if @@user.password == c
            puts "Please enter new password"
            d = STDIN.noecho(&:gets).chomp
            @@user.update(password: d)
            puts "Your password has been successfully updated."
            sleep 1
            Startup.return_to_main
        else
            puts "Incorrect password - please try again"
            sleep 1
            Startup.password_change
        end
    end

    def self.text_flasher(text)
        puts "\e[5m#{text}\e[0m"
    end

    def self.delete_account
        puts "Are you sure you want to delete your account #{@@user.name}? If so please type DELETE to confirm.".colorize(:red)
        d = gets.chomp
        if d == "DELETE"
            Client.delete_account(@@user.email)
            deletion_msg = "Account Deleted!!".colorize(:red)
            6.times do
                print "\r#{ deletion_msg }"
                sleep 0.5
                print "\r#{ ' ' * deletion_msg.size }" # Send return and however many spaces are needed.
                sleep 0.5
              end
            sleep 3
            Startup.home_menu
        else
            prompt = TTY::Prompt.new
            choice = prompt.select("Deletion cancelled! Can we still be friends??".colorize(:red), "Return to main menu")
            if choice == "Return to main menu"
                Startup.logged_in_menu
            end
        end
    end

    #global helper functions
    def self.putsyellow(text)
        puts text.colorize(:yellow)
    end

    def self.putsgreen(text)
        puts text.colorize(:green)
    end

    def self.return_to_main
        prompt = TTY::Prompt.new
        choice = prompt.select("", "Return to main menu", "Logout")
        if choice == "Return to main menu"
            Startup.logged_in_menu
        else
            Startup.home_menu
        end
    end

    def self.continue_to_main
        prompt = TTY::Prompt.new
        choice = prompt.select("", "Continue to main menu", "Exit")
        if choice == "Continue to main menu"
            Startup.logged_in_menu
        else
            Startup.home_menu
        end
    end
end
