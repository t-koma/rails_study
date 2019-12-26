class ExportcsvController < ApplicationController
  require 'csv'

  #請求一覧CSV吐き出し
  def index
    #支払いがすんでいないデータを表示
    @clients = Claim.where(pay: false)
    today = Time.now.strftime('%Y%m%d%H%M%S')
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_csv render_to_string,filename:"#{today}_非常食部請求一覧.csv",type: :csv
      end
    end
  end
  
end
