class Claim < ApplicationRecord
	validates :user_id, presence: true
	validates :claim, presence: true
	validates :claim_day, presence: true
end
