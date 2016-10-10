class GroupTeacher < ActiveRecord::Base
    
# This is a join table pairing groups (classes) and teachers.

	validates :teacher_id, :uniqueness => { :scope => :group_id }

	belongs_to :teacher
	belongs_to :group
	belongs_to :center
end
