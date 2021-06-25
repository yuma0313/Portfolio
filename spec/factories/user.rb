FactoryBot.define do
  factory :user do
    id { 2 }
    email { 'user@example.com' }
    name { 'ユーザー' }
    password { '12341234' }
    password_confirmation { '12341234' } 
    profile { 'よろしくお願いします。' }
    is_valid { true }
    
    after(:create) do |user|
      user.activate!
    end
  end
end
