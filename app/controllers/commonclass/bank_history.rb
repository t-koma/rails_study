class BankHistory < ApplicationController
  before_action :set_current_user

def bank_update(collect_day,collect_money,coll,admin_user)
    #bankに当月分データとして登録
    from = collect_day.to_date.beginning_of_month
    to = collect_day.to_date.end_of_month

    bank = Bank.find_by(warehousing:nil, bank_day: from..to)

    if bank
      #当月分データがあれば更新
      bank.bank_day = to
      bank.warehousing = nil
      bank.wh_id = admin_user
      bank.return_money = 0 #非常食部会計
      if coll
        #修正なら前回徴収金額を引いて今回修正金額を加算
        bank.money = bank.money - coll.collect + collect_money.to_i
      else
        #新規徴収なら何もせず加算
        bank.money = bank.money + collect_money.to_i
      end
    else
      #当月分データがなければ追加
      bank = Bank.new
      bank.bank_day = to
      bank.warehousing = nil
      bank.wh_id = admin_user
      bank.money = collect_money.to_i
      bank.return_money = 0 #非常食部会計
    end

    bank.save

  end
end