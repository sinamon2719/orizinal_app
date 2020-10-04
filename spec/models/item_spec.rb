require 'rails_helper'
RSpec.describe Item, type: :model do
  describe Item do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item, user_id: @user.id)

    end

    describe '実装の条件' do
      context '商品が出品できる場合' do
        it '必須項目が間違いなく入力されていれば進める' do
          expect(@item).to be_valid
        end
      end
      context '出品出来ない場合' do
        it '商品名が必須であること' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("商品名を入力してください")
        end
        it '商品の説明が必須であること' do
          @item.content = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の説明を入力してください")
        end
        it 'カテゴリーの情報が必須であること' do
          @item.category_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
        end
        it '配送料の負担についての情報が必須であること' do
          @item.shipping_cost_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
        end
        it '発送元の地域についての情報が必須であること' do
          @item.prefecture_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
        end
        it '発送までの日数についての情報が必須であること' do
          @item.shipping_day_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
        end
        it '価格についての情報が必須であること' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("価格を入力してください")
        end
        it '価格の範囲が、¥300~¥9,999,999の間であること①299円以下' do
          @item.price = '100'
          @item.valid?
          expect(@item.errors.full_messages).to include("価格は一覧にありません")
        end
        it '価格の範囲が、¥300~¥9,999,999の間であること②10,000,000円以上' do
          @item.price = '100000000'
          @item.valid?
          expect(@item.errors.full_messages).to include("価格は一覧にありません")
        end
        it '1が選択された場合は、出品できないこと（日数）' do
          @item.shipping_day_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("発送までの日数は1以外の値にしてください")
        end
        it '1が選択された場合は、出品できないこと（カテゴリー）' do
          @item.category_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("カテゴリーは1以外の値にしてください")
        end
        it '1が選択された場合は、出品できないこと（発送地域）' do
          @item.prefecture_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("発送元の地域は1以外の値にしてください")
        end
        it '1が選択された場合は、出品できないこと（コスト）' do
          @item.shipping_cost_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("配送料の負担は1以外の値にしてください")
        end
        it '販売価格は半角数字のみ入力可能であること' do
          @item.price = '１１１'
          @item.valid?
          expect(@item.errors.full_messages).to include("価格は一覧にありません")
        end
      end
    end
  end
end