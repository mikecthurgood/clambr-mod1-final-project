class Trainer < ActiveRecord::Base
    has_many :clients, through: :sessions
    has_many :walls, through: :sessions
    has_many :sessions
    has_many :availabilitys
end
