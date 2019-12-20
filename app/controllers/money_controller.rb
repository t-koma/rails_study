class MoneyController < ApplicationController
  before_action :check_login_user
	before_action :set_club
  require 'csv'

  def index
  	@banks = Bank.all.order(bank_day: :desc)
    choice_radio
    params[:choice] = "すべて"
  end

 
  #残金計算
  def balance(bank)
    logger.debug("balance:#{@Balance}")
    if bank == nil

      @remine = {balance:@Balance,message:""}
    elsif bank.warehousing.to_i > 0 && bank.wh_id == @club_user
        @Balance = @Balance - bank.money.to_i
        message = ""
      #立替て入荷したがすでに非常食部財布から返却した場合
      elsif bank.warehousing.to_i > 0 && bank.return_money == 1 && bank.wh_id != @club_user
        @Balance = @Balance - bank.money.to_i
        message="返金済"
      #立替て入荷したがまだ非常食部財布から返却していない場合
      elsif bank.warehousing.to_i > 0 && bank.return_money == 2 && bank.wh_id != @club_user
        message="未返金"
      #入金時
      elsif bank.warehousing == nil
        @Balance = @Balance + bank.money.to_i
        message="徴収"
      else
        @Balance = 0
        message = "Error!"
      end
      @remine = {balance:@Balance,message:message}
  end

  def shopping_history

  end

  def edit
  	@bank_data = Bank.find_by(id: params[:id])
  end

  def create 
    bank_data = Bank.new
    bank_data.bank_day = params[:money_date].to_date
    bank_data.warehousing = params[:warehousing].to_i
    bank_data.wh_id = params[:wh_name] 
    bank_data.money = params[:money].to_i
    if params[:wh_name] == @club_user
      bank_data.return_money = 0 #非常食部会計
    else
      bank_data.return_money = 2
    end

    if bank_data.save
      flash[:notice] ="登録が完了しました"
      redirect_to("/menu/index")
    else
      flash[:notice] = "登録に失敗しました"
      render("money/new")
    end
  end

  def update
  	bank_fix_data = Bank.find_by(id:params[:id].to_i)
  	bank_fix_data.bank_day = params[:date].to_date
  	bank_fix_data.warehousing = params[:wareh]
  	bank_fix_data.wh_id = params[:wh_name]
  	bank_fix_data.money = params[:money].to_i
  	bank_fix_data.return_money = params[:radio]

  	if bank_fix_data.save
  		flash[:notice] = "更新が完了しました"
  		redirect_to("/money/index")
  	else
  		flash[:notice] = "更新に失敗しました"
  		render("money/#{params[:id]}/edit")
  	end
  end

  def new

  end

  def choice
    case params[:choice]
      when "入荷" then
        @banks = Bank.where("warehousing > ?",0)
      when "返却済" then
        @banks = Bank.where(return_money:1)
      when "未返却" then
        @banks = Bank.where(return_money:2)
      when "徴収" then
        @banks = Bank.where(warehousing:nil)
      else
        @banks = Bank.all
    end
    choice_radio
    render("money/index")
  end

  #radioボタンの値
  def choice_radio
    @radio_name = ["すべて","入荷","返却済","未返金","徴収"]
  end

  #請求一覧CSV吐き出し
  def exp_csv
    #支払いがすんでいないデータを表示
    @clients = Claim.where(pay: false)
    logger.debug(@clients)
    if @clients.present? == false
      flash[:notice] ="未徴収者はいません"
      redirect_to("/collect/index") and return
    end
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

  helper_method :balance

end
