FactoryBot.define do
  factory :user_order do
    post_code { '563-0027' }
    city { '1-14-2'}
    address {'池田市上池田'}
    phone_number {'08064452444'}
    token {'hogehoge'}
    prefecture_id {2}
    association :user
    association :item
  end
end
