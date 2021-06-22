class Admin::PostUsersController < ApplicationController
    before_action :authenticate_admin!
  def index
    @post_users = PostUser.page(params[:page])
  end

  def show
    @post_user = PostUser.find(params[:id])
  end

  def edit
    @post_user = PostUser.find(params[:id])
  end

  def update
    post_user = PostUser.find(params[:id])
    post_user.update(post_user_params)
    redirect_to admin_post_user_path(post_user)
  end


  private
  def post_user_params
    params.require(:post_user).permit(:nickname, :image, :introduction, :is_deleted)
  end
end
