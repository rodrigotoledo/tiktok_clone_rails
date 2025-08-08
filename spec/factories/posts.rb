FactoryBot.define do
  factory :post do
    title { "MyString" }
    body { "MyText" }
    user
  end
end
