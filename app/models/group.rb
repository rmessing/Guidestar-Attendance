class Group < ActiveRecord::Base

	# A group is a school class of several children.

	validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }

	has_many :children, dependent: :nullify
	has_many :group_teachers
	has_many :teachers, :through => :group_teachers
	belongs_to :center
	belongs_to :location
end
