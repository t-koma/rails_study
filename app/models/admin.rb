class Admin < ApplicationRecord
	validates :user_id, presence: true
	validates :name, presence: true
	validates :pass, presence: true

	def price=(value)
	    value.tr!('０-９', '0-9') if value.is_a?(String)
	    super(value)
  	end
end
