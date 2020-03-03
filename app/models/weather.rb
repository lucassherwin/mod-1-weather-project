class Weather < ActiveRecord::Base
    belongs_to :users
    belongs_to :locations
end

#this joins location and users