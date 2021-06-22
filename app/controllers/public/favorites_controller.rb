class Public::FavoritesController < ApplicationController
  before_action :post_params

  def create
    @post = Post.find(params[:post_id])
    favorite = current_post_user.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_post_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

  def post_params
    @post = Post.find(params[:post_id])
  end

end
