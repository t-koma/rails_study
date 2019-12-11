class Hope < ApplicationRecord
	validates :user_id, presence: true
	validates :contents, length: { maximum: 20 }      # 「20文字以下」
end
