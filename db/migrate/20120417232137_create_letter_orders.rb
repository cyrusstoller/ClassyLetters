class CreateLetterOrders < ActiveRecord::Migration
  def change
    create_table :letter_orders do |t|
      t.integer :user_id
      t.date :preferred_delivery_date
      t.string :signed_name
      t.date :message_display_date
      t.text :message

      t.timestamps
    end
    
    add_index :letter_orders, :user_id
  end
end
