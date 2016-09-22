class Family < ActiveRecord::Base
	belongs_to :center
	belongs_to :parent
	belongs_to :children
end
