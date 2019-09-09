class Session < ActiveRecord::Base
    belongs_to :client
    belongs_to :wall #ask mani
    belongs_to :trainer
    belongs_to :startup

    def self.book
        puts "Hi, who are you booking a session for?"
            username_input = STDIN.gets.chomp
            user = Client.find_or_create_by(name: username_input)
            username = user.name
        puts "Welcome #{username}! Which wall would you like to book a session at?"
            desired_wall = STDIN.gets.chomp
            wall = Wall.find_by(name: desired_wall)
        if wall
            coach = Trainer.all.sample
            Session.create(wall_id: wall.id, client_id: user.id, trainer_id: coach)
        else
            puts "Sorry, that wall doesn't exist. Please try again"
        end
    end

end
    
