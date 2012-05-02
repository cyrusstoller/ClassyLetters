class AddExtrasToLetterOffer < ActiveRecord::Migration
  def change
    add_column :letter_orders, :doodle,    :boolean, :default => false
    add_column :letter_orders, :lipstick,  :boolean, :default => false
    add_column :letter_orders, :teardrops, :boolean, :default => false
    add_column :letter_orders, :in_person, :boolean, :default => false
  end
end
