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
    @coll = Collect.find_by(claim_id:@cla.id)
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
    if params[:claim_money].to_i == params[:collect_money].to_i
      cla.pay = true
    else
      cla.pay = false
    end

    coll = Collect.find_by(claim_id:cla.id)

    #bankテーブルの更新
    bank_history = BankHistory.new
    if bank_history.bank_update(params[:collect_day],params[:collect_money],coll,@club_user) == false
      flash[:notice] = "入出金履歴への反映に失敗しました"
      render("user_history/edit")
    end

    #徴収入力データがない場合新規追加
    if coll == nil
      coll = Collect.new
      coll.user_id = params[:user_id]
      coll.admin_user_id = params[:admin_id]
      coll.claim_id = cla.id
    end
    
    #修正内容反映
    cla.claim_day = params[:claim_day]
    cla.claim = params[:claim_money]
    coll.collect_day = params[:collect_day]
    coll.collect = params[:collect_money]

    if cla.save && coll.save 
      flash[:notice] = "更新が完了しました"
      redirect_to("/user_history/#{cla.user_id}/index")
    else
      flash[:notice] = "更新に失敗しました"
      render("user_history/edit")
    end
  end
end
