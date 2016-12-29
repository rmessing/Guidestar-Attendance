class Handoff < ActiveRecord::Base
 
 	belongs_to :child
	belongs_to :center

	def self.search(search)
		if search
			where(["child_fname LIKE ?","%#{search}%"])
		else
		    all
		end
	end
end
