# frozen_string_literal: true

FactoryBot.define do
  factory :following do
    association :user, factory: :user
    association :follower, factory: :user
    accepted { false }
  end
end
