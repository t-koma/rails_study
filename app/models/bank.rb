class Bank < ApplicationRecord
	validates :money, presence: true
	validates :bank_day,presence:true
end
