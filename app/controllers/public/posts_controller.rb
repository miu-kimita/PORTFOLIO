class Public::PostsController < ApplicationController
  before_action :ensure_post_user, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @user = @post.post_user
    @new_post = Post.new
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @user = current_post_user
    @genres = Genre.all
    @genre = Genre.new
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def create
    @post = Post.new(post_params)
    @post.post_user_id = current_post_user.id
    if @post.save
      redirect_to post_path(@post)
      flash[:notice]= "Welcome! You have created LifeHack successfully."
    else
      @posts = Post.all
      @user = current_post_user
      render :index
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.post_user_id = current_post_user.id
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:notice]= "You have updated LifeHack successfully"
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

  def ensure_post_user
    @posts = current_post_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to posts_path unless @post
  end

  def post_params
    params.require(:post).permit(:title, :post_detail,:genre_id,:image,:image_id)
  end

end