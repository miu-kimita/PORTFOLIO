class Admin::PostUsersController < ApplicationController
    before_action :authenticate_admin!
  def index
    @post_users = PostUser.page(params[:page])
  end

  def show
    @post_user = PostUser.find(params[:id])
  end

  private
  def post_user_params
    params.require(:post_user).permit(:nickname, :image, :introduction, :is_deleted)
  end
end
