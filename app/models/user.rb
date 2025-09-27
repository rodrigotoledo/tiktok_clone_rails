# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  generates_token_for :password_reset, expires_in: 15.minutes
  generates_token_for :email_confirmation, expires_in: 24.hours

  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_one :account
end
