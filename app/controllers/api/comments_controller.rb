# frozen_string_literal: true

class Api::CommentsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def index
    comments = @post.comments.order(created_at: :desc).includes(:user)
    render json: { comments: CommentBlueprint.render_as_json(comments) }
  end

  def create
    comment = @post.comments.build(comment_params.merge(user: Current.session.user))
    if comment.save
      render json: comment, include: :user, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
