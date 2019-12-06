class MoneyController < ApplicationController
  before_action :check_login_user
	before_action :set_club

  def bank_statement
  	@banks = Bank.all.order(bank_day: :desc)
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
      bank_data.return_money = 0
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
  		redirect_to("/money/bank_statement")
  	else
  		flash[:notice] = "更新に失敗しました"
  		render("money/#{params[:id]}/edit")
  	end
  end

  def new

  end
end
