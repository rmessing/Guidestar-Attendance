class Location < ActiveRecord::Base
validates_presence_of :name, on: :create, presence: true, length: { maximum: 30 } 
	
	has_many :groups
	belongs_to :location
	belongs_to :center
end
