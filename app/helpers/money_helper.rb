module MoneyHelper
  #残金計算
  def balance(bank)
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

  def safe
    safe = Safe.find_by(id:1)
    @Balance = safe.balance
  end
end
