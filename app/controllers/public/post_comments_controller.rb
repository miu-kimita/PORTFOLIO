require 'language'
class Public::PostCommentsController < ApplicationController
  before_action :post_params

  def create
    @post = Post.find(params[:post_id])
    comment = current_post_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.score = ::Language.get_data(post_comment_params[:comment])
    #(現状コメントか投稿かどちらに着けるべきか悩ましいために保留)
    comment.save
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,:post_id,:post_user_id)
  end

  def post_params
    @post = Post.find(params[:post_id])
  end
end
