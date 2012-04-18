class CreateLettreOrders < ActiveRecord::Migration
  def change
    create_table :lettre_orders do |t|
      t.integer :user_id
      t.date :preferred_delivery_date
      t.string :signed_name
      t.date :message_display_date
      t.text :message

      t.timestamps
    end
    
    add_index :lettre_orders, :user_id
  end
end
