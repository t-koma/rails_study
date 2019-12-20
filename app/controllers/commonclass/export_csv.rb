class ExportCSV < ApplicationController
  require 'csv'

  #請求一覧CSV吐き出し
  def exp_csv(format)
    #支払いがすんでいないデータを表示
    @clients = Claim.where(pay: false)
    logger.debug("exp_csv start")
    respond_to do |format|
      logger.debug("exp_csv respond")
      format.html
        logger.debug("exp_csv format.html")
      format.csv do |csv|
        send_posts_csv(@clients)
      end
    end
  end

  #CSVテンプレ
  def send_posts_csv(clients)
    logger.debug ("send_posts_csv")
    csv_data = CSV.generate do |csv|
      header = %W(名前 金額 請求日)
      csv << header

      clients.each do |client|
        user = User.find_by(id:client.user_id)
        values = [
          user.name,
          client.claim,
          client.claim_day
        ]
        csv << values
      end
    end
    send_csv(csv_data,filename:"非常食部請求一覧.csv")
  end
end
