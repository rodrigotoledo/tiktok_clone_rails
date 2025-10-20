# frozen_string_literal: true

class Api::PostsController < Api::ApplicationController
  before_action :authenticate_user!
  def index
    posts = Current.session.user
      .posts
      .order(created_at: :desc)
      .includes(:user)

    render json: { posts: PostBlueprint.render_as_json(posts) }
  end
end
