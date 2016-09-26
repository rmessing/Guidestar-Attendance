class Family < ActiveRecord::Base

    validates :child_id, :parent_id, :center_id, presence: true
	validates :child_id, :uniqueness => { :scope => :parent_id }

	belongs_to :center
	belongs_to :parent
	belongs_to :children
end
