# frozen_string_literal: true

FactoryBot.define do
  factory :following do
    user { nil }
    follower_id { 1 }
    accepted { false }
  end
end
