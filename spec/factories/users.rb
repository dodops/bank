FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    sequence(:api_token) { |n| "c23je2j4#{n}23242#{n}asas" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
