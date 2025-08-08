FactoryBot.define do
  factory :comment do
    post
    user
    body { "MyText" }
  end
end
