class ApplicationController < ActionController::Base
	before_action :set_current_user
	
	def set_current_user
    	@current_user = Admin.find_by(user_id: session[:admin_id])
  	end

end
