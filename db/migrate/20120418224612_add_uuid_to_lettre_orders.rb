class AddUuidToLettreOrders < ActiveRecord::Migration
  def change
    add_column :lettre_orders, :uuid, :string
    add_index  :lettre_orders, :uuid
  end
end
