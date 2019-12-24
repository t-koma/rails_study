class Hope < ApplicationRecord
	validates :user_id, presence: true
	validates :contents, length: { maximum: 20 }      # 「20文字以下」

  def user
    @user = User.find_by(id:self.user_id)
  end
end
