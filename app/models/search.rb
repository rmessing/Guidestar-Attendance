class Search < ActiveRecord::Base

	def search_handoffs

		handoffs = Handoff.all

		handoffs = handoffs.where(["child_lname LIKE ?","%#{child_name}%"]) if child_name.present?
		handoffs = handoffs.where(["group_name LIKE ?","%#{class_name}%"]) if class_name.present?
		handoffs = handoffs.where(["escort_lname LIKE ?","%#{adult_name}"]) if adult_name.present?
		handoffs = handoffs.where(["location_name LIKE ?","%#{location_name}"]) if location_name.present?

		return handoffs
	end
end
