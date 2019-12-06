class UserController < ApplicationController
  def user_info
  	@users = User.all.order("id")
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
  	@user = User.find_by(id:params[:id])
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
  	flash[:notice] = "削除が完了しました"
	redirect_to("/user/info")
  end


end


