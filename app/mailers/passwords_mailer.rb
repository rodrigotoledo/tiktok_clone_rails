# frozen_string_literal: true

class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail subject: "Reset your password", to: user.email_address
  end

  def reset_from_api(user)
    @user = user
    mail subject: "Reset your password", to: user.email_address
  end
end
