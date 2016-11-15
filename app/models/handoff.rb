class Handoff < ActiveRecord::Base
# Under construction.
# A handoff is the event when a parent drops-off or picks-up a child at/from the daycare center.

	belongs_to :child
	belongs_to :center
end
