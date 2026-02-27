# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    association :user
    info { Faker::Lorem.sentence }
  end
end
