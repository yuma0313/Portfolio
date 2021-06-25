require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "Factories" do
    # 有効なファクトリを持つ(ユーザー)
    it "is valid with valid factory" do
      expect(build(:user)).to be_valid
    end
  end
  
  describe "Validations" do
    # メールアドレスがなければ無効
    it { is_expected.to validate_presence_of(:email) }
    
    # パスワード(6文字以上)がなければ無効
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  
    # 確認用パスワードがなければ無効
    it { is_expected.to validate_presence_of(:password_confirmation) }
  end
  
  describe "Associations" do
    # 以下の関連を持つ
    it { should have_many(:post_images)}
    it { should have_many(:favorites)}
    it { should have_many(:favorited_post_images)}
    it { should have_many(:events)}
    it { should have_many(:bookmarks)}
    it { should have_many(:bookmarked_post_image)}
    it { should have_many(:sns_credentials)}
  end
end