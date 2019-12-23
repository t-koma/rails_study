class UserHistoryController < ApplicationController
	require './app/controllers/commonclass/bank_history'
	before_action :set_current_user
	before_action :check_login_user

  def index
  	@clas = Claim.where(user_id:params[:id])
  end

  def edit
  	#各パラメータ取得
    @cla = Claim.find_by(id:params[:id])
    @user = User.find_by(id:@cla.user_id)
    @coll = @cla.collect
    #徴収管理未入力の場合
    if @coll
      @admin = Admin.find_by(user_id:@coll.admin_user_id)
    else
      @admin = Admin.find_by(user_id:@current_user.user_id)
    end
  end

  def update
  	cla = Claim.find_by(id:params[:id])

    #請求金額と徴収金額を比較して支払い済フラグを更新する
    if params[:claim].to_i == params[:collect].to_i
      cla.pay = true
    else
      cla.pay = false
    end
    coll = cla.collect

    #bankテーブルの更新
    bank_history = BankHistory.new
    if bank_history.bank_update(params[:collect_day],params[:collect],coll,@club_user) == false
      flash[:notice] = "入出金履歴への反映に失敗しました"
      render("user_history/edit")
    end

    #徴収入力データがない場合新規追加
    if coll == nil
      coll = Collect.new(collect_params)
      coll.claim_id = cla.id
      result_flg_coll = coll.save
    else
      result_flg_coll = coll.update(collect_params)
    end
    
    #修正内容反映
    result_flg_claim = cla.update(claim_params)

    if result_flg_coll && result_flg_claim
      flash[:notice] = "更新が完了しました"
      redirect_to("/user_history/#{cla.user_id}/index")
    else
      flash[:notice] = "更新に失敗しました"
      render("user_history/edit")
    end
  end

  private
  def claim_params
    params.permit(:claim_day, :claim)
  end

  def collect_params
    params.permit(:user_id, :admin_user_id, :collect_day, :collect)
  end
end
