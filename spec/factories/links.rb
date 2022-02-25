FactoryBot.define do
  factory :link do
    url { Faker::Internet.url  }
    slug { "" }
  end
end
