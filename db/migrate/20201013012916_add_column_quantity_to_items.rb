class AddColumnQuantityToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :channel, :string
    add_column :items, :quantity, null: false
    add_column :items, :rest_quantity, default: 0
  end
end
