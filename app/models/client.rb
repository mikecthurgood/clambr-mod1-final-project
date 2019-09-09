class Client < ActiveRecord::Base
    has_many :sessions
    has_many :walls, through: :sessions

    def find_a_wall(name)
        Wall.find_by(name: name) 
    end
    
    def book_a_session(wall)
        Session.create(wall_id: wall.id, client_id: self.id)
    end

    def cancel_last_session(wall)
        Session.find(self.id).first.destroy
    end

    def which_walls?
        self.walls.map(&:name)
    end

    def which_trainers?
        self.trainers.map(&:name)
    end

    def number_of_sessions?
        self.all_walls_attended.length
    end

    def self.banned_user?(email)
        BannedUser.all.find_by(email: email)
    end

    def self.create_user(name, grade, email)
        if Client.banned_user?(email)
            puts "#{email} is blacklisted, jog on."
        elsif email == nil
            puts "Please input an email address"
        else
        Client.create(name: name, grade: grade, email: email)
        end
    end

        

end
    
