class Family < ActiveRecord::Base

	# This is a join table with unique parent-child pairings.  A parent is an Adult authorized to drop-off or pick-up a child at/from the daycare center.

	validates :child_id, :uniqueness => { :scope => :parent_id }

	belongs_to :center
	belongs_to :parent
	belongs_to :child
end
