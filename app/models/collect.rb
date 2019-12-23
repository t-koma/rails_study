class Collect < ApplicationRecord
	validates :user_id, presence: true
	validates :collect, presence: true

	def claim
		@claim = Claim.find_by(id:self.claim_id)
	end

end
