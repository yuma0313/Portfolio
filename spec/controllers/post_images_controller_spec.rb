# require 'rails_helper'

# describe PostImagesController, type: :controller do
#   let(:user) { create(:user) }
#   let(:post_image) { create(:post_image) }

#   describe '投稿一覧画面のテスト' do
#     before do
#       visit post_images_path
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/post_images'
#       end
#       it '自分の投稿と他人の投稿のタイトルのが表示される' do
#         expect(page).to have_content post_image.name
#         expect(page).to have_content other_post_image.name
#       end
#       it '自分の投稿と他人の投稿のキャプションが表示される' do
#         expect(page).to have_content post_image.caption
#         expect(page).to have_content other_post_image.caption
#       end
#       it '自分の投稿と他人の投稿の都道府県が表示される' do
#         expect(page).to have_content post_image.prefecture
#         expect(page).to have_content other_post_image.prefecture
#       end
#       it '自分の投稿と他人の投稿の所在地が表示される' do
#         expect(page).to have_content post_image.address
#         expect(page).to have_content other_post_image.address
#       end
#     end

#     context 'サイドバーの確認' do
#       it '「新規投稿フォーム」と表示される' do
#         expect(page).to have_content '新規投稿フォーム'
#       end
#       it '画像フォームが表示される' do
#         expect(page).to have_button 'ファイルを選択'
#       end
#       it 'titleフォームが表示される' do
#         expect(page).to have_field 'post_image[name]'
#       end
#       it 'titleフォームに値が入っていない' do
#         expect(find_field('post_image[name]').text).to be_blank
#       end
#       it 'captionフォームが表示される' do
#         expect(page).to have_field 'post_image[caption]'
#       end
#       it 'captionフォームに値が入っていない' do
#         expect(find_field('book[body]').text).to be_blank
#       end
#       it '投稿ボタンが表示される' do
#         expect(page).to have_button '投稿'
#       end
#     end
#   end
# end