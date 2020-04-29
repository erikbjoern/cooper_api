FactoryBot.define do
  factory :user do
    email { "test@cooper.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
