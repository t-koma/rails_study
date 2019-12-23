class AdminController < ApplicationController
  before_action :set_current_user
  before_action :check_login_user, only: [:logout, :admin_user_index, :new, :create, :edit, :update]

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
    if session[:admin_id] 
      redirect_to("/menu/index")
    end
  end

  def logout
    if session[:admin_id]
      session[:admin_id] = nil
      flash[:notice] = "ログアウトしました"
    end
    redirect_to("/admin/login")
  end

  def admin_user_index
    @admins = Admin.all.order("user_id")

  end

  def new

  end

  def create
    @admin = Admin.new(admin_params)
    if params[:pass] != params[:pass_confirmation]
      flash[:notice] = "パスワードに誤りがあります"
      render("admin/new") and return
    end

    if @admin.save
      flash[:notice] ="登録が正常に終了しました"
      redirect_to("/admin/index")
    else
      flash[:notice] = "登録に失敗しました"
      render("admin/new") and return
    end

  end

  def edit
    @admin = Admin.find_by(id:params[:id])
  end

  def update
    @admin = Admin.find_by(id:params[:id])
    if params[:pass] != params[:pass_confirmation]
      flash[:notice] = "パスワードに誤りがあります"
      render("admin/edit") and return
    end

    if @admin.update(admin_params)
      flash[:notice] ="登録が正常に終了しました"
      redirect_to("/admin/index")
    else
      flash[:notice] = "登録に失敗しました"
      render("admin/edit") and return
    end

  end

  private
  def admin_params
    params.permit(:user_id,:pass,:name)
  end
end

