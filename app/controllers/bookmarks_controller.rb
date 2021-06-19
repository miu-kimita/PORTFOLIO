class BookmarksController < ApplicationController
  before_action :authenticate_post_user!

  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.new(post_user_id: current_post_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.find_by(post_user_id: current_post_user.id)
    if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end
end