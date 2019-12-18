class CollectController < ApplicationController
  require './app/controllers/commonclass/bank_history'
  before_action :set_current_user
  before_action :check_login_user
  def show
  	@claim = Claim.find_by(id:params[:id])
    @user = User.find_by(id:@claim.user_id)
    @coll = Collect.find_by(claim_id:@claim.id)
  end

  def index
  	@clients = Claim.where(pay: false)
  end

  def new
  	@claim = Claim.find_by(id:params[:id])
    @user = User.find_by(id:@claim.user_id)
    @coll = Collect.find_by(claim_id:@claim.id)
  end

  def create
  	#新規データ追加
    coll = Collect.find_by(claim_id:params[:id].to_i)

    #bankテーブルの更新
    bank_history = BankHistory.new
    if bank_history.bank_update(params[:collect_day],params[:collect_money],coll,@club_user) == false
      flash[:notice] = "入出金履歴への反映に失敗しました"
      render("collect/new")
    end

    if coll == nil
      coll = Collect.new
    end
    coll.user_id = params[:user_id]
    coll.collect = params[:collect_money]
    coll.collect_day = params[:collect_day]
    coll.admin_user_id = params[:admin_id]
    coll.claim_id = params[:id].to_i

    cla = Claim.find_by(id:params[:id])

    #請求と徴収の金額が一致した場合、支払い済みフラグを建てる
    if cla.claim == params[:collect_money].to_i
      cla.pay = true
      if cla.save == false
        flash[:notice] = "更新に失敗しました"
        render("collect/new")
      end
    end

    #徴収管理テーブルへ保存
    if coll.save
      flash[:notice] = "登録に成功しました"
      redirect_to("/collect/index")
    else
      flash[:notice] = "登録に失敗しました"
      render("collect/new")
    end
   end
end
