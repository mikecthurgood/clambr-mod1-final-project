class Trainer < ActiveRecord::Base
    has_many :clients, through: :sessions
    has_many :walls, through: :sessions
    has_many :sessions

    def make_available
        self.availability = true
    end

    def make_unavailable
        self.availability = false
    end

    def available?
        self.availability
    end
    

    def session_count
        self.sessions.all.length
    end

    def ban_client(email)
        user = Client.find_by(email: email)
        user.destroy
        BannedUser.create(email: email)
        # finish this method by putting flow control into the Client class to check the banlist for the email a new user tries to input
        # and return a message saying "Sorry that email is blacklisted"
        puts "#{name} has been removed from the database and added to the blacklist. Unlucky."
    end
end


# session count 
# list of clients
# number of clients
