class Location < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 30 }, uniqueness: { scope: [ :center_id], case_sensitive: false }
	has_many :groups, dependent: :destroy
	has_many :children, dependent: :destroy
	belongs_to :center
end
