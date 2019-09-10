require_relative '../../config/environment.rb'
class Startup

    @quote = ["Training is like fighting a bear. You don't stop when you're tired, you stop when the bear's tired!", "There are no shortcuts to any place worth going.", "You cannot teach a man anything. You can only help him discover it within himself.", "A man can seldom -- very, very, seldom -- fight a winning fight against his training; the odds are too heavy.", ]

    @@user = nil

    def self.home_menu
        @@user = nil
    prompt = TTY::Prompt.new
        puts "LOGIN MENU"
        choice = prompt.select("What would you like to do?", "Create new account", "Login")
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
        puts " "
        puts " "
        puts '        ^\_ '
        puts '    o_/^   \ '
        puts '    /_^     `_ '
        puts '    \/^       \ '
        puts '    / ^         \ '
        puts '    ^             ` '
        puts " "
            if @@user
                puts "Hi #{@@user.name}! Welcome to Clambr."
            else    
        puts "Welcome to Clambr."
            end
        puts "The climbing trainer."
        puts " "
        puts "Thought for the day:"
        puts @quote.sample
        puts " "
        prompt = TTY::Prompt.new
        puts "HOME MENU"
        choice = prompt.select("What would you like to do?", "Update or delete my account", "Book a session", "See my stats", "Logout")
        case choice
            when "Update or delete my account"
                Startup.update_account
            when "Book a session"
                Startup.book_session    
            when "See my stats"
                Startup.stats_menu
            when "Logout"
                Startup.home_menu
        end
    end

    def self.update_account
        prompt = TTY::Prompt.new
        puts "UPDATE ACCOUNT"
        choice = prompt.select("What would you like to change?", "Name", "Grade", "Email", "Delete my account", "Return to home")
        case choice
        
        when "Name"
                puts "Hi #{@@user.name}, please enter your new username."
                a = gets.chomp
                @@user.update(name: a)
                puts " "
                puts "No problem, from now on you shall be known as #{@@user.name}!"
                puts " "
                Startup.return_to_main
                

        when "Grade"
            puts "Hi #{@@user.name}, please select your new grade (<- ->)"
            Startup.grade_slider
            puts " "
            puts "Climbing at V#{@@user.grade}! You're crushing it!"
            puts " "
            sleep 2
            Startup.return_to_main
        
        when "Email"
            puts "Hi #{@@user.name}, please enter your new email address"
            c = gets.chomp
            valid_email = Client.valid_email?(c)
            if valid_email
                @@user.update(email: c)
                puts " "
                puts "Great! We'll use #{@@user.email} for your login email! "
                puts " "
                sleep 2
                Startup.return_to_main
            else
                puts " "
                choice = prompt.select("That's not a valid email addres", "Return to update my account menu")
                if choice == "Return to main menu"
                    Startup.update_account
                end
            end
        
        when "Delete my account"
            puts "Are you sure you want to delete your account #{@@user.name}? If so please type DELETE to confirm."
            d = gets.chomp
            if d == "DELETE"
                Client.delete_account(@@user.email)
                puts "Account Deleted!!"
                sleep 3
                Startup.home_menu
            else
                choice = prompt.select("Deletion cancelled! Can we still be friends?", "Return to main menu")
                if choice == "Return to main menu"
                    Startup.logged_in_menu
                end
            end
        
        when "Return to home"
            Startup.logged_in_menu
        end
    end

    def self.area_selector
        puts"Ok!"
        prompt = TTY::Prompt.new
        choice = prompt.select("Which area of London are you in", "North London", "East London", "South London", "West London")
        self.wall_selector(choice)
    end

    def self.wall_selector(location)
        case location
        when "North London"
            prompt = TTY::Prompt.new
            @choice = prompt.select("Which wall would you like to book a session at?", Wall.where(area: "North London").map(&:name))
        when "East London"
            prompt = TTY::Prompt.new
            @choice = prompt.select("Which wall would you like to book a session at?", Wall.where(area: "East London").map(&:name))
        when "South London"
            prompt = TTY::Prompt.new
            @choice = prompt.select("Which wall would you like to book a session at?", Wall.where(area: "South London").map(&:name))
        when "West London"
            prompt = TTY::Prompt.new
            @choice = prompt.select("Which wall would you like to book a session at?", Wall.where(area: "West London").map(&:name))
        end
    end

    def self.stats_menu
        num_sesh = @@user.number_of_sessions?
        w = @@user.which_walls?
        t = @@user.which_trainers?
        gra = @@user.grade
        puts "Hi #{@@user.name}. Here's your current Clambr stats:"
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

    def self.user_login
        @@user = Startup.account_finder
        if @@user
            Startup.logged_in_menu
        else
            puts "Hmm, I can't seem to find the email address"
            choice = prompt.select("Try again or create new account?", "Try again", "Create new account")
        case choice
            when "Create new account"
                Startup.create_new_account
                Startup.logged_in_menu
            when "Try again"
                Startup.account_finder
            end
        end
    end

    def self.account_finder
        puts "Please input the email address associated with your account."
        email = gets.chomp
        a = Client.find_by(email: email)
        a
    end

    def self.create_new_account
        puts "What's your name?"
            a = gets.chomp
            puts "What grade do you climb at? (1 - 10)?"
            b = gets.chomp
            puts "what's your email address?"
            c = gets.chomp
            if Client.valid_email?(c)
                @@user = Client.create_user(a, b, c)
                puts "Thanks #{@@user.name}. Just to confirm, you climb at grade V#{@@user.grade} and we'll contact you on #{@@user.email}!"
                puts " "
                puts " "
                sleep 1
            else
                "Email invalid, please try again"
                sleep 1
                choice = prompt.select("", "Try again", "Logout")
                    if choice == "Try again"
                        Startup.create_new_account
                    else
                        Startup.home_menu
                    end
            end
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

    def self.book_session
        a = Startup.area_selector
        j = Wall.find_by(name: a)
        c = Client.find_by(email: @@user.email)
        if c
            d = Session.create(client_id: c.id, trainer_id: rand(1..20), wall_id: j.id)
            puts "That session's all booked for you #{c.name}. You'll be climbing with #{d.trainer.name} at #{d.wall.name}"
            sleep 1
            Startup.return_to_main
        end
    end

    def self.grade_slider
        prompt = TTY::Prompt.new
        choice = prompt.slider("select your grade",{min: 0, max: 10, step: 1})
        @@user.update(grade: choice)
    end

end
