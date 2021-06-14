class Admin::PostsController < ApplicationController
  before_action :authenticate_user!,except: [:sign_in]
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @new_post = Post.new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @user = current_post_user
  end

  def create
    @post = post.new(post_params)
    @post.user_id = current__post_user.id
    if @post.save
      redirect_to post_path(@post)
      flash[:notice]= "Welcome! You have created LifeHack successfully."
    else
      @posts = post.all
      @user = current_post_user
      render :index
    end
  end

  def new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:notice]= "You have updated LIfeHack successfully"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def ensure_user
    @posts = current_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to posts_path unless @post
  end

  def post_params
    params.require(:post).permit(:title, :post_detail)
  end

end