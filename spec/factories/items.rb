FactoryBot.define do
  before do
    @item.image = fixture_file_upload('public/view/2jpg')
  end
  factory :item do
    name { Faker::Name.initials(number: 2) }
    price { 350 }
    content {'hogehoge'}
    shipping_cost_id {2}
    shipping_day_id {2}
    prefecture_id {2}
    category_id {3}
    user_id {2}
    association :user
    youtube_url{"https://youtu.be/0rIwEMDHWOI"}
    quantity{1}
  end
end
