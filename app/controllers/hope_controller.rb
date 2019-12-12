class HopeController < ApplicationController
  def index
  	@hope = Hope.all
  end

  def new 
  	

  end

  def create
  	hope = Hope.new
  	hope.user_id = params[:user_id]
  	hope.contents = params[:contents]

  	if hope.save
  		flash[:notice] = "登録が完了しました"
  		redirect_to("/hope/index")
  	else
  		flash[:notice] = "登録に失敗しました"
  		render("hope/new")
  	end

  end

  def edit
  	#削除ボタン押下
  	if params[:complete]
  		hope = Hope.find_by(id:params[:id])
  		hope.destroy
  		flash[:notice] ="削除しました"
  		redirect_to("/hope/index")
	  else
		  @hope = Hope.find_by(id:params[:id])
	  	@user = User.find_by(id:@hope.user_id)
	  	@users = User.all
  	end

  end

  def update
  	@hope = Hope.find_by(id:params[:id])
  	@hope.user_id = params[:user_id]
  	@hope.contents = params[:contents]
    @user = User.find_by(id:@hope.user_id)
    @users = User.all

  	if @hope.save
  		flash[:notice] ="更新が完了しました"
  		redirect_to("/hope/index")
  	else
  		flash[:notice] ="更新に失敗しました"
  		render("hope/edit")
  	end

  end
end
