class Child < ActiveRecord::Base
	validates :fname, :lname, presence: true, length: { maximum: 30 }
	
	has_many :handoffs
	has_many :families
	has_many :parents, :through => :families
	belongs_to :group
	belongs_to :center
end

def child_full_name
    "#{fname} #{mname} #{lname}"
end