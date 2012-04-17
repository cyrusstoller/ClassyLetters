# == Schema Information
# Schema version: 20120417232137
#
# Table name: lettre_orders
#
#  id                      :integer         not null, primary key
#  user_id                 :integer
#  preferred_delivery_date :date
#  signed_name             :string(255)
#  message_display_date    :date
#  message                 :string(255)
#  created_at              :datetime        not null
#  updated_at              :datetime        not null
#

class LettreOrder < ActiveRecord::Base
  attr_accessible :message, :message_display_date, :preferred_delivery_date, :signed_name
  
  validates_presence_of :message
  validates_presence_of :preferred_delivery_date
  validates_presence_of :user_id
  
  belongs_to :user
end
