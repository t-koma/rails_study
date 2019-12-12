class Claim < ApplicationRecord
	validates :user_id, presence: true
	validates :claim, presence: true,numericality:{greater_than: 0} 
	validates :claim_day, presence: true
end
