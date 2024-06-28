# spec/factories/applications.rb
FactoryBot.define do
  factory :application do
    sequence(:name) { |n| "Test App #{n}" }
    token { SecureRandom.hex(10) }
  end
end
