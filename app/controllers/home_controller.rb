class HomeController < ApplicationController
  def index
    @posts = Current.session&.user.posts.order(created_at: :desc).includes(:user, :comments).limit(10)
  end
end
