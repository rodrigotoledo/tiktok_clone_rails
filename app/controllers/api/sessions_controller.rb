# frozen_string_literal: true

module Api
  class SessionsController < Api::ApplicationController
    rate_limit to: 10, within: 3.minutes, only: :create, with: -> { render json: { error: "Try again later." }, status: :too_many_requests }

    def create
      if user = User.authenticate_by(params.permit(:email_address, :password))
        token = login(user)
        render json: { message: "Session created successfully", user: user.attributes.except("password_digest"), token: token }, status: :created
      else
        head :unauthorized
      end
    end

    def destroy
      logout current_user
      head :no_content
    end
  end
end
