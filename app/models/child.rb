class Child < ActiveRecord::Base

	validates :fname, :lname, presence: true, length: { maximum: 30 }
	validates :group_id, presence: true
	validates :location_id, presence: true
    #first and last name of child must be unique within their center.
	validates :mname, uniqueness: { scope: [:fname, :lname, :center_id], case_sensitive: false }

	has_many :handoffs
	has_many :families, dependent: :destroy
	has_many :parents, :through => :families
	
	belongs_to :group
	belongs_to :center
	belongs_to :location
end

def child_full_name
    "#{fname} #{mname} #{lname}"
end

