class Client < ActiveRecord::Base
    has_many :sessions
    has_many :walls, through: :sessions
end
    
