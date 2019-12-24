class HopeController < ApplicationController
  before_action :check_login_user
  def index
  	@hope = Hope.all
  end

  def new 
  	

  end

  def create
  	hope = Hope.new(hope_params)

  	if hope.save
  		flash[:notice] = "登録が完了しました"
  		redirect_to("/hope/index")
  	else
  		flash[:notice] = "登録に失敗しました"
  		render("hope/new")
  	end

  end

  def edit
	  @hope = Hope.find_by(id:params[:id])
  	@user = @hope.user
  	@users = User.all

  end

  def update
  	@hope = Hope.find_by(id:params[:id])
    @user = @hope.user
    @users = User.all

  	if @hope.update(hope_params)
  		flash[:notice] ="更新が完了しました"
  		redirect_to("/hope/index")
  	else
  		flash[:notice] ="更新に失敗しました"
  		render("hope/edit")
  	end

  end

  def destroy
    hope = Hope.find_by(id:params[:id])
    hope.destroy
    flash[:notice] ="削除しました"
    redirect_to("/hope/index")
  end

  private

  def hope_params
    params.permit(:user_id, :contents)
  end
end
