class Wall < ActiveRecord::Base
    has_many :sessions
    has_many :clients, through: :sessions

    def self.find_by_location(location)
        self.find_by(location: location)
    end

    def self.find_by_area(area)
        self.where(area: area)
    end

end


    
