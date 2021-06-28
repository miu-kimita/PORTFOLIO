class Public::PostUsersController < ApplicationController
  before_action :authenticate_post_user!
  before_action :ensure_post_user, only: [:edit, :update, :destroy]

  def index
    @post_users = PostUser.page(params[:page]).reverse_order
    @post_user = current_post_user
    @post = Post.new
    @posts = Post.all
  end

  def show
    if params[:id] != nil
      @post_user = PostUser.find(params[:id])
    else
      @post_user = current_post_user
    end
    #IF分で条件分岐をつけ、カレントユーザーのIDが無い時はどの様なIDをつけるべきかをこちらとビュー側で指定する

    @posts = @post_user.posts.page(params[:page]).reverse_order
    @bookmarks = Bookmark.where(post_user_id: current_post_user.id)
    @nickname = current_post_user.nickname
  end

  def edit
    @post_user = PostUser.find(params[:id])
  end

  def update
    @post_user = PostUser.find(current_post_user.id)
    if @post_user.update(post_user_params)
      flash[:notice]= "You have updated UserData successfully"
      redirect_to post_user_path(current_post_user)
    else
      @posts = @post_user.posts
      @post = Post.new
      render 'edit'
    end
  end

  def destroy
    @post_user = PostUser.find(params[:id]) #ユーザ毎の情報を得る
    @post_user.destroy #ユーザ情報を削除（退会）
    redirect_to root_path #削除後、topに移動させる
  end

  private

  def ensure_post_user
    @post_user = PostUser.find(params[:id])
    if current_post_user.id != @post_user.id
    redirect_to post_user_path(current_post_user)
    end
  end


  def post_user_params
    params.require(:post_user).permit(:nickname, :image, :introduction)
  end
end