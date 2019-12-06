class MoneyController < ApplicationController
	before_action :set_club

  def bank_statement
  	@banks = Bank.all.order(bank_day: :desc)
  end

  def shopping_history

  end

  def edit
  	@bank_data = Bank.find_by(id: params[:id])

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
end
