require_relative '../../config/environment.rb'
class Startup

    @quote = ["Training is like fighting a bear. You don't stop when you're tired, you stop when the bear's tired!", "There are no shortcuts to any place worth going.", "You cannot teach a man anything. You can only help him discover it within himself.", "A man can seldom -- very, very, seldom -- fight a winning fight against his training; the odds are too heavy.", ]

def self.home_menu
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
    puts "Thought for the day:"
    puts @quote.sample
    puts " "

    prompt = TTY::Prompt.new
    puts "HOME MENU"
    choice = prompt.select("What would you like to do?", "Create new account", "Update or delete my account", "Book a session", "See my stats")
    case choice
        when "Create new account"
            Startup.create_new_account
            Startup.home_menu
        when "Update or delete my account"
            Startup.update_account
        when "Book a session"     
            a = Startup.area_selector
            j = Wall.find_by(name: a)
            puts "what's your email address"
            b = gets.chomp
            c = Client.find_by(email: b)
            if c
                d = Session.create(client_id: c.id, trainer_id: rand(1..20), wall_id: j.id)
                puts "That session's all booked for you #{c.name}. You'll be climbing with #{d.trainer.name} at #{d.wall.name}"
                sleep 1
                Startup.home_menu
            else
                if
                    Client.banned_user?(b)
                    "You're banned mate. Off you trot."
                else
                    puts "Hmm, we don't seem to have that email address on record."
                    sleep 1
                    puts "What's your name?"
                    e = gets.chomp
                    puts "What grade do you climb at?"
                    f = gets.chomp
                    h = Client.create_user(e, f, b)
                    k = Session.create(client_id: h.id, trainer_id: rand(1..20), wall_id: j.id)
                    puts "That session's all booked for you #{h.name}. You'll be climbing with #{k.trainer.name} at #{k.wall.name}"
                    sleep 1
                    Startup.home_menu
                end
            end

        when "See my stats"
            Startup.stats_menu
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
                user = Client.create_user(a, b, c)
                puts "Thanks #{user.name}. Just to confirm, you climb at grade V#{user.grade} and we'll contact you on #{user.email}!"
                puts " "
                puts " "
                sleep 1
                Startup.home_menu
            else
                "Please input a valid email address"
                sleep 1
                Startup.home_menu
            end
end

def self.update_account
    prompt = TTY::Prompt.new
    puts "UPDATE ACCOUNT"
    choice = prompt.select("What would you like to change?", "Name", "Grade", "Email", "Delete my account", "Return to home")
    case choice
    
    when "Name"
        user = Startup.account_finder
        if user
            puts "Hi #{user.name}, please enter your new username."
            a = gets.chomp
            user.update(name: a)
        else
            puts "Account not found."
            Startup.home_menu
        end

    when "Grade"
        user = Startup.account_finder
        puts "Hi #{user.name}, please enter your new grade"
        b = gets.chomp
            user.update(grade: b)
            puts "Climbing at V#{user.grade}! You're crushing it!"
            sleep 2
            Startup.home_menu
    
    when "Email"
        user = Startup.account_finder
        puts "Hi #{user.name}, please enter your email"
        c = gets.chomp
        valid_email = Client.valid_email?(c)
        if valid_email
            user.update(email: c)
        else
            puts " "
            choice = prompt.select("That's not a valid email addres", "Return to main menu")
            if choice == "Return to main menu"
                Startup.home_menu
        end
    
    when "Delete my account"
        user = Startup.account_finder
        puts "Are you sure you want to delete your account #{user.name}? If so please type DELETE to confirm."
        d = gets.chomp
        if d = "DELETE"
            Client.delete_account(user.email)
        else
            choice = prompt.select("Deletion cancelled! Can we still be friends?", "Return to main menu")
            if choice == "Return to main menu"
                Startup.home_menu
        end
    
    when "Return to home"
        Startup.home_menu
    end
end

def self.area_selector
    puts"Ok!"
    prompt = TTY::Prompt.new
    choice = prompt.select("Which area of London are you in", "North London", "East London", "South London", "West London")
    self.wall_selector(choice)
end


    # @north_london_walls = Wall.find_by_area("North London")
    # @east_london_walls = Wall.find_by_area("East London")
    # @south_london_walls = Wall.find_by_area("South London")
    # @west_london_walls = Wall.find_by_area("West London")

    def self.wall_names(walls)
        walls.each do |wall|
            puts "#{wall.name}, #{wall.location}"
        end

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
    user = Startup.account_finder
    num_sesh = user.number_of_sessions?
    w = user.which_walls?
    t = user.which_trainers?
    gra = user.grade
    puts "Hi #{user.name}. Here's your current Clambr stats:"
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
    choice = prompt.select("Done?", "Return to main menu")
    if choice == "Return to main menu"
        Startup.home_menu
    end

    
end
    
end
