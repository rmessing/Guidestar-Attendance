class Location < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 30 }, uniqueness: { scope: [ :center_id], case_sensitive: false }
	has_many :groups
	belongs_to :center
end
