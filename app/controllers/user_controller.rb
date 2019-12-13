class UserController < ApplicationController
  before_action :check_login_user
  
  def user_info
  	@users = User.all.order("id")
    if params[:history]
      render("money/history")
    end
  end

  def hope
  end

  def new

  end

  def create
  	user = User.new
  	user.name = params[:name]

  	if user.save
  		flash[:notice] = "登録が完了しました"
  		redirect_to("/user/info")
  	else
  		flash[:notice] ="登録に失敗しました"
  		render("user/new")
  	end 
  end

  def edit
  	
    if params[:history]
      redirect_to("/money/#{params[:id]}/history")
    elsif params[:fixed]
      @user = User.find_by(id:params[:id])
    else
      redirect_to("/menu/index")
    end
  end

  def update
  	user = User.find_by(id:params[:id])
  	user.name = params[:name]
  	if user.save
  		flash[:notice] = "更新が完了しました"
  		redirect_to("/user/info")
  	else
  		flash[:notice] = "更新に失敗しました"
  		render("user/new")
  	end
  end

  def destroy
  	user = User.find_by(id:params[:id])
  	user.destroy
    claim = Claim.where(user_id:params[:id])
    claim.destroy_all
    collect = Collect.where(user_id:params[:id])
    collect.destroy_all
    hope = Hope.where(user_id:params[:id])
    hope.destroy_all
  	flash[:notice] = "削除が完了しました"
	  redirect_to("/user/info")
  end


end


