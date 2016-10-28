class Handoff < ActiveRecord::Base
# Under construction.
# A handoff is the event when a parent drops-off or picks-up a child at/from the daycare center.

	validates_presence_of :attend, on: :create, presence: true
	belongs_to :child
	belongs_to :center
end
