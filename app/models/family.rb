class Family < ActiveRecord::
	belongs_to :child
	belongs_to :parent
	belongs_to :center
end
