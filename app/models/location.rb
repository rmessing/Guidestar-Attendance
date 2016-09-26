class Location < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false}
	
	has_many :groups
	belongs_to :center
end
