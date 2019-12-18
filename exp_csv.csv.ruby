require 'csv'

CSV.generate do |csv|
	column_names = %w('名前' '金額' '請求日')
	csv << column_names

	@clients.each do |client|
		user = User.find_by(id:client.user_id)
		column_values = [
			user.name,
			client.claim,
			client.claim_day
		]
		csv << column_values
	end
end