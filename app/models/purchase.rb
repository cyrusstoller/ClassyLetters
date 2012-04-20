# == Schema Information
# Schema version: 20120420233855
#
# Table name: purchases
#
#  id                 :integer         not null, primary key
#  lettre_order_id    :integer
#  last_four          :integer
#  stripe_id          :string(255)
#  stripe_fingerprint :string(255)
#  card_type          :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

class Purchase < ActiveRecord::Base
  attr_accessible :card_type, :last_four, :lettre_order_id, :stripe_fingerprint, :stripe_id
  
  validates_presence_of :lettre_order_id
  validates_uniqueness_of :lettre_order_id
  validates_presence_of :last_four
  validates_presence_of :stripe_id
  validates_presence_of :stripe_fingerprint
  validates_presence_of :card_type, :on => :create, :message => "can't be blank"
  
  belongs_to :lettre_order, :class_name => "LettreOrder", :foreign_key => "lettre_order_id"
end
