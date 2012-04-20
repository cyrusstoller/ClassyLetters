class AddDeliveryStatusToLettreOrders < ActiveRecord::Migration
  def change
    add_column :lettre_orders, :delivery_status,  :integer, :default => 0
    add_column :lettre_orders, :assigned_user_id, :integer
  end
end
