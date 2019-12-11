class Collect < ApplicationRecord
	validates :user_id, presence: true
	validates :collect, presence: true
end
