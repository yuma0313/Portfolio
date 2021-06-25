FactoryBot.define do
  factory :post_image do
    id { 1 }
    name { 'ほげカフェ' }
    prefecture { 13 } # 東京
    address { 'ほげ市ほげ丁目123-456' }
    phone { '0123-456-789' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
  end
end