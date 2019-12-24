class Claim < ApplicationRecord
	validates :user_id, presence: true
	validates :claim, presence: true,numericality:{greater_than: 0} 
	validates :claim_day, presence: true

  def collect
    @collect = Collect.find_by(claim_id:self.id)
  end

  def user
    @user = User.find_by(id:self.user_id)
  end
end
