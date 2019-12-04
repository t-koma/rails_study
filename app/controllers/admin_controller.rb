class AdminController < ApplicationController
  def login
  	@admin = Admin.find_by(user_id: params[:user_id], pass: params[:pass])
  	if @admin
  		session[:admin_id] = @admin.user_id
  		flash[:notice] = "ログインしました"
  		redirect_to("/menu/index")
  	else
  		flash[:notice] = "ユーザーIDまたはパスワードが異なります"
  		render("admin/login_form")
  	end

  end

  def login_form

  end

  def logout
    if session[:admin_id]
      session[:admin_id] = nil
      flash[:notice] = "ログアウトしました"
    end
    redirect_to("/admin/login")
  end
end

def admin_user_index

end
