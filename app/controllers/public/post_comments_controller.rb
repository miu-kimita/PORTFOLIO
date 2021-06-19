class Public::PostCommentsController < ApplicationController
  before_action :post_params

  def create
    comment = current_post_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def post_params
    @post = Post.find(params[:post_id])
  end
end
