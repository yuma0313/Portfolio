require 'rails_helper'

Rspec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧のユーザ画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(user)
      end
      it '投稿一覧に自分の投稿のnameが表示される' do
        expect(page).to have_content post_image.name
      end
      it '投稿一覧に自分の投稿のcaptionが表示される' do
        expect(page).to have_content post_image.caption
      end
      it '投稿一覧に自分の投稿のprefectureが表示される' do
        expect(page).to have_content post_image.prefecture
      end
      it '投稿一覧に自分の投稿のaddressが表示される' do
        expect(page).to have_content post_image.address
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: user_path(other_user)
        expect(page).not_to have_content other_post_image.name
        expect(page).not_to have_content other_post_image.caption
        expect(page).not_to have_content other_post_image.prefecture
        expect(page).not_to have_content other_post_image.address
      end
    end
    
    context 'サイドバーの確認' do
      it 'ホームリンクが表示される' do
        expect(page).to have_link 'ホーム', href: root_path
      end
      it '投稿リンクが表示される' do
        expect(page).to have_link '投稿', href: post_images_path
      end
      it 'いいねリンクが表示される' do
        expect(page).to have_link 'いいね', href: post_image_favorites_path(post_image)
      end
      it 'ブックマークリンクが表示される' do
        expect(page).to have_link 'ブックマーク', href: post_image_bookmarks_path(post_image)
      end
      it 'スケジュールリンクが表示される' do
        expect(page).to have_link 'スケジュール', href: events_path
      end
      it '退会リンクが表示される' do
        expect(page).to have_link '退会する', href: confirm_unsubscribe_path(user)
      end
    end
  end
    
  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '自己紹介編集フォームに自分のメールアドレスが表示される' do
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '変更内容を保存ボタンが表示される' do
        expect(page).to have_button '変更内容を保存'
      end
    end
    
    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_email = user.email
        fill_in 'user[name]', with: Faker::Lorem.characters
        fill_in 'user[email]', with: Faker::Lorem.characters
        click_button '変更内容を保存'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'emailが正しく更新される' do
        expect(user.reload.email).not_to eq @user_old_email
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end