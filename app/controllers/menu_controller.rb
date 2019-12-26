class MenuController < ApplicationController
	before_action :check_login_user
  before_action :set_current_user
  def index
  end

end
