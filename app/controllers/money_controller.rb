class MoneyController < ApplicationController
  before_action :check_login_user
	before_action :set_club

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

  def edit
  	@bank_data = Bank.find_by(id: params[:id])
  end

  def create 
    bank_data = Bank.new(money_params)

    if params[:wh_id] == @club_user
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

  	if bank_fix_data.update(money_params)
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

  

  helper_method :balance

  private

  def money_params
    params.permit(:bank_day, :warehousing, :wh_id, :money, :return_money)
  end

end
