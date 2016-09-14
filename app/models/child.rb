class Child < ActiveRecord::Base
	validates_presence_of :fname, :lname, on: :create, presence: true, length: { maximum: 30 }

	has_many :handoffs
	has_many :families
	has_many :parents, :through => :families
	belongs_to :group
	belongs_to :center
end

def child_full_name
    "#{fname} #{mname} #{lname}"
end