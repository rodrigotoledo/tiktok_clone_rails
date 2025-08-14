# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = Current.session&.user
    if @comment.save
      render json: {}, status: :no_content
    else
      redirect_to root_path, alert: "Could not add comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
