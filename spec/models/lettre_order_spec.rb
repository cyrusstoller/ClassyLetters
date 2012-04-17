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

require 'spec_helper'

describe LettreOrder do
  describe "validations" do
    it "should not be valid without a user_id" do
      Factory.build(:lettre_order, :user_id => nil).should_not be_valid
    end
    
    it "should not be valid without a preferred_delivery_date" do
      Factory.build(:lettre_order, :preferred_delivery_date => nil).should_not be_valid
    end
    
    it "should not be valid without a message" do
      Factory.build(:lettre_order, :message => nil).should_not be_valid
    end
  end
  
  describe "connections" do
    it "should respond to user" do
      Factory.build(:lettre_order).should respond_to(:user)
    end
  end
end
