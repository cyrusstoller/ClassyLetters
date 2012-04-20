# == Schema Information
# Schema version: 20120419205958
#
# Table name: lettre_orders
#
#  id                      :integer         not null, primary key
#  user_id                 :integer
#  preferred_delivery_date :date
#  signed_name             :string(255)
#  message_display_date    :date
#  message                 :text
#  created_at              :datetime        not null
#  updated_at              :datetime        not null
#  address_street1         :string(255)
#  address_street2         :string(255)
#  address_city            :string(255)
#  address_state           :string(255)
#  address_zip             :string(255)
#  paper_size              :integer         default(0)
#  writing_style           :integer         default(0)
#  wax_seal                :boolean         default(FALSE)
#  uuid                    :string(255)
#  doodle                  :boolean         default(FALSE)
#  lipstick                :boolean         default(FALSE)
#  teardrops               :boolean         default(FALSE)
#  in_person               :boolean         default(FALSE)
#  delivery_status         :integer         default(0)
#  assigned_user_id        :integer
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

    it "should have a preferred_delivery_date at least two days in the future" do
      Factory.build(:lettre_order, :preferred_delivery_date => Time.now.to_date).should_not be_valid
    end
    
    it "should be valid with a preferred_delivery_date two days in the future" do
      Factory.build(:lettre_order, :preferred_delivery_date => Time.now.to_date + 2.days).should be_valid
    end
    
    it "should not be valid without a message" do
      Factory.build(:lettre_order, :message => nil).should_not be_valid
    end
    
    it "should not be valid without a street address1" do
      Factory.build(:lettre_order, :address_street1 => nil).should_not be_valid
    end
    
    it "should be valid without a street address 2" do
      Factory.build(:lettre_order, :address_street2 => nil).should be_valid
    end
    
    it "should not be valid without a city address" do
      Factory.build(:lettre_order, :address_city => nil).should_not be_valid
    end
    
    it "should not be valid withouat a state" do
      Factory.build(:lettre_order, :address_state => nil).should_not be_valid
    end
    
    it "should not be valid if the state is longer than 2 letters" do
      Factory.build(:lettre_order, :address_state => "ABC").should_not be_valid
    end
    
    it "should not be valid without a zip code" do
      Factory.build(:lettre_order, :address_zip => nil).should_not be_valid
    end
    
    it "should not be valid with a zip code that doesn't match the regex" do
      Factory.build(:lettre_order, :address_zip => "ABCDE").should_not be_valid
    end
    
    it "should not have a paper style greater than 2" do
      Factory.build(:lettre_order, :paper_size => 3).should_not be_valid
    end
    
    it "should be valid with a paper style equal to 2" do
      Factory.build(:lettre_order, :paper_size => 2).should be_valid
    end
    
    it "should not have a writing style greater than 2" do
      Factory.build(:lettre_order, :writing_style => 3).should_not be_valid
    end
    
    it "should be valid with a writing style equal to 2" do
      Factory.build(:lettre_order, :writing_style => 2).should be_valid
    end
    
    it "should be valid" do
      Factory.build(:lettre_order).should be_valid
    end
  end
  
  describe "connections" do
    it "should respond to user" do
      Factory.build(:lettre_order).should respond_to(:user)
    end
    
    it "should respond to assigned_user" do
      Factory.build(:lettre_order).should respond_to(:assigned_user)
    end
    
  end
  
  describe "display message" do
    it "should respond to display_message" do
      Factory.build(:lettre_order).should respond_to(:display_message)
    end
    
    it "should substitute \\n with <br/>" do
      Factory.build(:lettre_order, :message => "Luv\nCyro").display_message.should == "Luv<br/>Cyro"
    end
  end
  
  describe "price" do
    it "should respond to price" do
      Factory.build(:lettre_order).should respond_to(:price)
    end
  end
  
  describe "extras" do
    it "should respond to extra_charge_for_characters" do
      Factory.build(:lettre_order).should respond_to(:extra_charge_for_characters)
    end

    it "should respond to has_extras?" do
      Factory.build(:lettre_order).should respond_to(:has_extras?)
    end
    
    it "should respond to extras_list" do
      Factory.build(:lettre_order).should respond_to(:extras_list)
    end
  end
  
  describe "delivery_status" do
    it "should not be valid with a delivery status > 2" do
      Factory.build(:lettre_order, :delivery_status => 3).should_not be_valid
    end
    
    it "should be valid with a delivery status = 0" do
      Factory.build(:lettre_order, :delivery_status => 0).should be_valid
    end
  end
  
end
