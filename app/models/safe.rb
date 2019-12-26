class Safe < ApplicationRecord
  validates :balance, presence: true
end
