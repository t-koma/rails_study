require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(名前 金額 請求日)
  csv << csv_column_names
  @clients.each do |client|
    csv_column_values = [
      client.user.name,
      client.claim,
      client.claim_day
    ]
    csv << csv_column_values
  end
end