# frozen_string_literal: true

class Following < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: 'User', optional: true
end
