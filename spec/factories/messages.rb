FactoryBot.define do
    factory :message do
      association :chat
      body { Faker::Lorem.sentence }
      number { 1 }
    end
  end
  