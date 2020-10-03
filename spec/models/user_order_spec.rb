require 'rails_helper'
RSpec.describe UserOrder, type: :model do
  describe UserOrder do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item, user_id: @user.id)
      @user_order = FactoryBot.build(:user_order, user_id: @user.id, item_id: @item.id)
    end

    describe '実装の条件' do
      context '購入情報がある場合' do
        it '必須項目が間違いなく入力されていれば進める' do
          expect(@user_order).to be_valid
        end
        it 'building_nameは空でも保存できること' do
          @user_order.building_name = nil
          expect(@user_order).to be_valid
        end
      end
      context '購入情報がない場合' do
        it '郵便番号が必須であること' do
          @user_order.post_code = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("郵便番号を入力してください")
        end
        it '都道府県が必須であること' do
          @user_order.prefecture_id = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("都道府県を入力してください")
        end
        it '1が選択された場合は、出品できないこと（発送地域）' do
          @user_order.prefecture_id = '1'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("都道府県は1以外の値にしてください")
        end
        it '番地の情報が必須であること' do
          @user_order.city = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("番地を入力してください")
        end
        it '市区町村についての情報が必須であること' do
          @user_order.address = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("市町村を入力してください")
        end
        it '電話番号が必須であること' do
          @user_order.phone_number = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("電話番号を入力してください")
        end
        it '郵便番号にはハイフンが必要であること' do
          @user_order.post_code = '5630027'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("郵便番号はハイフンを含んでください")
        end
        it '電話番号にはハイフンは不要であること' do
          @user_order.phone_number = '080-6174-9908'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("電話番号はハイフンは不要です")
        end
        it '電話番号は11桁以内であること' do
          @user_order.phone_number = '123123123123123'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("電話番号桁数が違います")
        end

        it 'トークンの情報が必須であること' do
          @user_order.token = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("クレジット情報を入力してください")
        end
      end
    end
  end
end
