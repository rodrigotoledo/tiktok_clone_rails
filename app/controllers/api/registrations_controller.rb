# frozen_string_literal: true

class Api::RegistrationsController < Api::ApplicationController

  def create
    @user = User.new(params.permit(:email_address, :password, :password_confirmation))
    if @user.save!
      login(@user)
      render json: { message: "Welcome, #{@user.email_address}!" }, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    logger.info "Error creating user: #{e.message}"
    head :bad_request
  end
end
