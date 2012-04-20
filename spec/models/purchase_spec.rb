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

require 'spec_helper'

describe Purchase do
  describe "validation" do
    it "should be invalid without a lettre_order_id" do
      Factory.build(:purchase, :lettre_order_id => nil).should_not be_valid
    end
    
    it "should be invalid if the lettre_order_id has already been used" do
      Factory(:purchase, :lettre_order_id => 1)
      Factory.build(:purchase, :lettre_order_id => 1).should_not be_valid
    end
    
    it "should be invalid without a last four" do
      Factory.build(:purchase, :last_four => nil).should_not be_valid
    end
    
    it "should be invalid without a stripe_id" do
      Factory.build(:purchase, :stripe_id => nil).should_not be_valid
    end
    
    it "should be invalid without a stripe_fingerprint" do
      Factory.build(:purchase, :stripe_fingerprint => nil).should_not be_valid
    end
    
    it "should be invalid without a card_type" do
      Factory.build(:purchase, :card_type => nil).should_not be_valid
    end
    
    it "should be valid" do
      Factory.build(:purchase).should be_valid
    end
  end
  
  describe "connections" do
    it "should respond to lettre_order" do
      Factory.build(:purchase).should respond_to(:lettre_order)
    end
  end
end
