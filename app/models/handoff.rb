class Handoff < ActiveRecord::Base
	validates_presence_of :attend, on: :create, presence: true
	belongs_to :child
	belongs_to :center
end
