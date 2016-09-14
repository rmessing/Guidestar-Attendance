class Group < ActiveRecord::Base
	validates_presence_of :name, on: :create, presence: true, length: { maximum: 30 } 
	has_many :children, dependent: :nullify
	has_many :teachers, :through => :group_teachers
	belongs_to :center
	belongs_to :location
end
