class Bank < ApplicationRecord
	validates :money, presence: true
	validates :money, numericality:{greater_than: 0} 
	validates :bank_day,presence:true
end
