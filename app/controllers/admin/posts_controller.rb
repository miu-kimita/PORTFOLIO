class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_post_user, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @user = @post.post_user
    @posts = Post.all
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
    @post = Post.new
    @user = current_post_user
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def ensure_user
    @posts = current_post_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to posts_path unless @post
  end

  def post_params
    params.require(:post).permit(:title, :post_detail)
  end

end