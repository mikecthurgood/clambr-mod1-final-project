class BannedUser < ActiveRecord::Base
    has_many :clients
    belongs_to :trainers
end