class CollectController < ApplicationController
  require './app/controllers/commonclass/bank_history'
  before_action :set_current_user
  before_action :check_login_user

  def index
  	@clients = Claim.where(pay: false)
  end

  def new
  	@claim = Claim.find_by(id:params[:id])
    @user = @claim.user
    @coll = @claim.collect
  end

  def create
  	#新規データ追加
    coll = Collect.find_by(claim_id:params[:id].to_i)

    #bankテーブルの更新
    bank_history = BankHistory.new
    if bank_history.bank_update(params[:collect_day],params[:collect],coll,@club_user) == false
      flash[:notice] = "入出金履歴への反映に失敗しました"
      render("collect/new")
    end

    if coll == nil
      coll = Collect.new(coll_params)
      #徴収管理テーブルへ保存
      result_flg = coll.save
    else
      result_flg = Collect.update(coll_params)
    end

    #請求と徴収の金額が一致した場合、支払い済みフラグを建てる
    cla = coll.claim
    if cla.claim == params[:collect].to_i
      cla.pay = true
      if cla.save == false
        flash[:notice] = "更新に失敗しました"
        render("collect/new")
      end
    end

    if result_flg
      flash[:notice] = "登録に成功しました"
      redirect_to("/collect/index")
    else
      flash[:notice] = "登録に失敗しました"
      render("collect/new")
    end

  end

   private

   def coll_params
   	 params.permit(:user_id, :collect, :collect_day,
   	 	:admin_user_id, :claim_id)
   end
end
