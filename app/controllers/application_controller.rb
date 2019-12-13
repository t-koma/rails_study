class ApplicationController < ActionController::Base
	before_action :set_current_user
	before_action :set_club
	
	def set_current_user
  		@current_user = Admin.find_by(user_id: session[:admin_id])
	end

	#「非常食部」のユーザーIDは999
	def set_club
		@club_user = "999"
		@Balance = 30000  #非常食部の財布残高
	end

	#ログインチェック
	def check_login_user
		if session[:admin_id] == nil
			flash[:notice]  = "ログインしてください"
			redirect_to("/")
		end
	end


end
