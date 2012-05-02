class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :letter_order_id
      t.integer :last_four
      t.string :stripe_id
      t.string :stripe_fingerprint
      t.string :card_type

      t.timestamps
    end
    
    add_index :purchases, :letter_order_id
  end
end
