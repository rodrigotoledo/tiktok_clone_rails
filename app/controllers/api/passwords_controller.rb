# frozen_string_literal: true

class Api::PasswordsController < Api::ApplicationController
  before_action :set_user_by_token, only: [ :update ]

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset_from_api(user).deliver_later
    end
    render json: { message: "Password reset instructions sent" }, status: :ok
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      render json: { message: "Password has been reset." }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token(params[:token])
      unless @user
        head :bad_request
      end
    end
end
