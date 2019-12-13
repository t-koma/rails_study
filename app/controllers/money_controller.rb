class MoneyController < ApplicationController
  before_action :check_login_user
	before_action :set_club

  def bank_statement
  	@banks = Bank.all.order(bank_day: :desc)
    params[:choice] = "すべて"
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
  		redirect_to("/money/bank_statement")
  	else
  		flash[:notice] = "更新に失敗しました"
  		render("money/#{params[:id]}/edit")
  	end
  end

  def new

  end

  def collect
    @claim = Claim.find_by(id:params[:id])
    @user = User.find_by(id:@claim.user_id)
    @coll = Collect.find_by(claim_id:@claim.id)
  end

  def collect_create

    now = Time.current 

    #新規データ追加
    coll = Collect.find_by(claim_id:params[:id].to_i)

    #bankに当月分データとして登録
    from = params[:collect_day].to_date.beginning_of_month
    to = params[:collect_day].to_date.end_of_month

    bank = Bank.find_by(warehousing:nil, bank_day: from..to)

    if bank && coll
      #当月分データがあれば更新
      bank.bank_day = to
      bank.warehousing = nil
      bank.wh_id = @club_user
      bank.return_money = 0 #非常食部会計
      if coll
        #修正なら前回徴収金額を引いて今回修正金額を加算
        bank.money = bank.money - coll.collect + params[:collect_money].to_i
      else
        #新規徴収なら何もせず加算
        bank.money = bank.money + params[:collect_money].to_i
      end
    else
      #当月分データがなければ追加
      bank = Bank.new
      bank.bank_day = to
      bank.warehousing = nil
      bank.wh_id = @club_user
      bank.money = params[:collect_money].to_i
      bank.return_money = 0 #非常食部会計
    end

    if bank.save == false
        flash[:notice] = "入出金履歴への反映に失敗しました"
        render("money/collect")
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
        render("money/collect")
      end
    end

    #徴収管理テーブルへ保存
    if coll.save
      flash[:notice] = "登録に成功しました"
      redirect_to("/money/collection")
    else
      flash[:notice] = "登録に失敗しました"
      render("money/collect")
    end
  end

  def history
    @clas = Claim.where(user_id:params[:id])
  end

  def history_fixed
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

  def history_update

    cla = Claim.find_by(id:params[:id])

    #請求金額と徴収金額を比較して支払い済フラグを更新する
    if params[:claim_money].to_i == params[:collect_money].to_i
      cla.pay = true
    else
      cla.pay = false
    end

    #bankに当月分データとして登録
    from = params[:collect_day].to_date.beginning_of_month
    to = params[:collect_day].to_date.end_of_month

    bank = Bank.find_by(warehousing:nil, bank_day: from..to)
    coll = Collect.find_by(claim_id:cla.id)

    #当月分データがあれば更新
    if bank
      bank.bank_day = to
      bank.warehousing = nil
      bank.wh_id = @club_user
      if coll
        bank.money = bank.money - coll.collect.to_i + params[:collect_money].to_i
      else
        bank.money = bank.money + params[:collect_money].to_i
      end
      bank.return_money = 0 #非常食部会計
    #当月分データがなければ追加
    else
      bank = Bank.new
      bank.bank_day = to
      bank.warehousing = nil
      bank.wh_id = @club_user
      bank.money = params[:collect_money].to_i
      bank.return_money = 0 #非常食部会計
    end

    if bank.save == false
        flash[:notice] = "入出金履歴への反映に失敗しました"
        render("money/history_fixed")
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
      redirect_to("/money/#{cla.user_id}/history")
    else
      flash[:notice] = "更新に失敗しました"
      render("money/history_fixed")
    end

  end

  def claim
    
  end

  def claim_create
    #新規データ追加
    cla = Claim.new
    cla.claim_day = params[:claim_day]
    cla.user_id = params[:user_id]
    cla.claim = params[:claim_money]
    cla.pay = false

    if cla.save
      flash[:notice] = "登録に成功しました"
      redirect_to("/money/collection")
    else
      flash[:notice] = "登録に失敗しました"
      render("money/claim")
    end
  end

  def collection
    now = Time.current
    #支払いがすんでいないデータを表示
    @clients = Claim.where(pay: false)

  end

  def client

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
    render("money/bank_statement")
  end

end
