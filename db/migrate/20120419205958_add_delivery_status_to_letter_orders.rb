class AddDeliveryStatusToLetterOrders < ActiveRecord::Migration
  def change
    add_column :letter_orders, :delivery_status,  :integer, :default => 0
    add_column :letter_orders, :assigned_user_id, :integer
  end
end
