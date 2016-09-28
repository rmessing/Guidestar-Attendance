class GroupTeacher < ActiveRecord::Base
    validates :group_id, :teacher_id, :center_id, presence: true
	validates :group_id, :uniqueness => { :scope => :teacher_id }

	belongs_to :teacher
	belongs_to :group
	belongs_to :center
end
