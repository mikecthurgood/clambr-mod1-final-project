class Session < ActiveRecord::Base
    belongs_to :client
    belongs_to :wall #ask mani
    belongs_to :trainer
    belongs_to :startup

end
    
