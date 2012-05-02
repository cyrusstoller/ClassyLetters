class AddUuidToLetterOrders < ActiveRecord::Migration
  def change
    add_column :letter_orders, :uuid, :string
    add_index  :letter_orders, :uuid, :unique => true
  end
end
