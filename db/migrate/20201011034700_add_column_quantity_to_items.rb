class AddColumnQuantityToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :quantity, :integer,              null: false
    add_column :items, :rest_quantity, :integer,         null: false
  end
end
