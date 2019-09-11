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

    def self.ban_client(email)
        user = Client.find_by(email: email)
        user.destroy
        BannedUser.create(email: email)
    end
end


# session count 
# list of clients
# number of clients
