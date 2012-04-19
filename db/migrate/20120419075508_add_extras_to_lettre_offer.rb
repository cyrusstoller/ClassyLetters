class AddExtrasToLettreOffer < ActiveRecord::Migration
  def change
    add_column :lettre_orders, :doodle,    :boolean, :default => false
    add_column :lettre_orders, :lipstick,  :boolean, :default => false
    add_column :lettre_orders, :teardrops, :boolean, :default => false
    add_column :lettre_orders, :in_person, :boolean, :default => false
  end
end
