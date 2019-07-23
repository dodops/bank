FactoryBot.define do
  factory :account do
    balance { "100,00" }
    user
  end
end
