FactoryBot.define do
  factory :post_image do
    id { 1 }
    name { 'ほげカフェ' }
    prefecture { 13 } # 東京
    address { 'ほげ市ほげ丁目123-456' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    user_id { 2 }
  end
end