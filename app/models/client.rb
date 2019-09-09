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

    def self.create_user(name, grade)
        Client.create(name: name, grade: grade)
    end

    def update_grade(grade)
        if grade.is_a?(integer)
            self.grade = grade
        else
            puts "invalid input - please input an integer"
        end
    end

end
    
