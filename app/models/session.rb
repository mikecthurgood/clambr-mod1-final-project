class Session < ActiveRecord::Base
    belongs_to :client
    belongs_to :wall #ask mani
    belongs_to :trainer

    # def self.book
    #     puts "Hi, who are you booking a session for?"
    #         username_input = gets.chomp
    #         user = find_or_create_by(name: username)
    #         username = user.name
    #     puts "Welcome #{username}! Which wall would you like to book a session at?"
    #         desired_wall = gets.chomp
    #         wall = find_a_wall(desired_wall)
    #     if wall
    #         Session.create(wall_id: wall.id, client_id: user.id)
    #     else
    #         puts "Sorry, that wall doesn't exist. Please try again"
    #     end
    # end

end
    
