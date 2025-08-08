FactoryBot.define do
  factory :user do
    email_address { "john@example.com" }
    password { "MyString123" }
    password_confirmation { "MyString123" }
  end
end
