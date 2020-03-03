class Location < ActiveRecord::Base
    has_many :weathers
    has_many :users, through: :weathers
end

#this connects location to users through weather