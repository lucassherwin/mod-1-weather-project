class User < ActiveRecord::Base
    has_many :weathers
    has_many :locations, through: :weathers
end

#this establishes relationship between users table and other tables