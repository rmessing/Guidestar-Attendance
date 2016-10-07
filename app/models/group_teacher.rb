class GroupTeacher < ActiveRecord::Base
    
# This is a join table pairing groups (classes) and teachers.

	validates :group_id, :uniqueness => { :scope => :teacher_id }

	belongs_to :teacher
	belongs_to :group
	belongs_to :center
end
