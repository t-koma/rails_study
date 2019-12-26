class SafeController < ApplicationController
  before_action :check_login_user
  def edit
    @safe = Safe.find_by(id:1)
  end

  def update
    @safe = Safe.find_by(id:params[:id])
    if @safe.update(safe_params)
      flash[:notice] = "更新しました"
      redirect_to("/money/index")
    else
      flash[:notice] ="更新に失敗しました"
      render("safe/edit")
    end
  end

  private

  def safe_params
    params.permit(:balance)
  end
end
