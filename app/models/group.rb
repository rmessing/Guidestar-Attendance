class Group < ActiveRecord::Base
	# A group is a educational class of several children; name must be unique within its center.
	validates :name, presence: true, length: { maximum: 30 }, uniqueness: { scope: [:location, :center_id], case_sensitive: false }
	validates :location_id, presence: true
	has_many :children, dependent: :nullify
	has_many :group_teachers
	has_many :teachers, :through => :group_teachers
	belongs_to :center
	belongs_to :location
end

