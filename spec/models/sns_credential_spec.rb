require 'rails_helper'

RSpec.describe SnsCredential, type: :model do

  describe "Factories" do
    # 有効なファクトリを持つ
    it "is valid with valid factory" do
      create(:user)
      expect(build(:sns_credential)).to be_valid
    end
  end

  describe "Associations" do
    # 以下の関連を持つ
    it { should belong_to(:user) }
  end
end