# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  has_many :posts, through: :user
end
