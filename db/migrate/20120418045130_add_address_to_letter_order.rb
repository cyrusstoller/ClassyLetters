class AddAddressToLetterOrder < ActiveRecord::Migration
  def change
    add_column :letter_orders, :address_street1, :string
    add_column :letter_orders, :address_street2, :string
    add_column :letter_orders, :address_city,    :string
    add_column :letter_orders, :address_state,   :string
    add_column :letter_orders, :address_zip,     :string
    
    add_column :letter_orders, :paper_size,     :integer, :default => 0
    add_column :letter_orders, :writing_style,  :integer, :default => 0  # print, cursive, caligraphy 
    add_column :letter_orders, :wax_seal,       :boolean, :default => false
  end
end
