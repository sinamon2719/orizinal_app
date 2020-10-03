class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string  :name,               null: false
      t.integer :price,              null: false
      t.text    :content,            null: false
      t.integer :shipping_cost_id
      t.integer :shipping_day_id
      t.integer :prefecture_id
      t.integer :category_id
      t.integer :user_id
      t.text :body # 追加
      t.string :youtube_url # 追加
      t.timestamps
    end
  end


end
