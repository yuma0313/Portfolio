FactoryBot.define do
  factory :sns_credential do
    user_id { 2 }
    uid { 108212587908146596723 }
    provider { 'twitter' }
  end
end