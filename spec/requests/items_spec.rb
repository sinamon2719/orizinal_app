require 'rails_helper'
describe ItemsController, type: :request do

  before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item, user_id: @user.id)
      @item.image = fixture_file_upload('public/view/2.jpeg')
      @item.save
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
      get item_path(@item.id)
      expect(response).to have_http_status(200)
    end
    it "showアクションにリクエストするとレスポンスに投稿済みの商品の名前が存在する" do 
      get item_path(@item.id)
      expect(response.body).to include @item.name
    end
    it "showアクションにリクエストするとレスポンスに投稿済みの商品の商品説明が存在する" do 
      get item_path(@item.id)
      expect(response.body).to include @item.content
    end
    it "showアクションにリクエストすると配送情報が存在する" do 
      get item_path(@item.id)
      expect(response.body).to include "配送情報"
    end
    it "showアクションにリクエストすると購入情報が存在する" do 
      get item_path(@item.id)
      expect(response.body).to include "購入情報"
    end
    it "showアクションにリクエストするとコメント/質問が存在する" do 
      get item_path(@item.id)
      expect(response.body).to include "コメント/質問"
    end
  end
end