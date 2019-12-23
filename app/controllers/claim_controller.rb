class ClaimController < ApplicationController
	before_action :set_current_user
	before_action :check_login_user

  def new
  	
  end

  def create
  	#新規データ追加
    cla = Claim.new(claim_params)
    cla.pay = false

    if cla.save
      flash[:notice] = "登録に成功しました"
      redirect_to("/collect/index")
    else
      flash[:notice] = "登録に失敗しました"
      render("claim/new")
    end
  end

  private
  def claim_params
    params.permit(:claim_day, :user_id, :claim)
  end

end
