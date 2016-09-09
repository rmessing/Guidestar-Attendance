class Group < ActiveRecord::Base
	validates_presence_of :name, on: :create, presence: true, length: { maximum: 30 } 
	has_many :children
	belongs_to :teacher
	belongs_to :center
	belongs_to :location
end
