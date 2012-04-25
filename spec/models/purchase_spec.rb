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
  
  def stripe_api_response
    {
      "created"=>1335248008, 
      "amount"=>0, 
      "disputed"=>false, 
      "card"=>{
        "address_country"=>nil, 
        "type"=>"Visa", 
        "address_zip_check"=>nil, 
        "fingerprint"=>"HzrHzq0Utd9W0pLp", 
        "address_state"=>nil, 
        "exp_month"=>12, 
        "address_line1_check"=>nil, 
        "country"=>"US", 
        "last4"=>"4242", 
        "exp_year"=>2013, 
        "address_zip"=>nil, 
        "object"=>"card", 
        "address_line1"=>nil, 
        "name"=>nil, 
        "address_line2"=>nil, 
        "id"=>"cc_y56GQT4SSdG0u5", 
        "cvc_check"=>nil
      }, 
      "invoice"=>nil, 
      "refunded"=>false, 
      "amount_refunded"=>0, 
      "currency"=>"usd", 
      "fee"=>0, 
      "failure_message"=>nil, 
      "object"=>"charge", 
      "livemode"=>false, 
      "description"=>nil, 
      "id"=>"ch_SrsONthza4OPl9", 
      "paid"=>true, 
      "customer"=>nil
    }
  end
  
  describe "save_with_payment" do 
    before(:each) do
      @lettre_order = Factory(:lettre_order)
      @purchase = @lettre_order.build_purchase(:stripe_card_token => "token")
    end
    
    it "should return true" do
      Stripe::Charge.stub(:create).and_return(stripe_api_response)
      @purchase.save_with_payment.should == true
    end
    
    it "should raise an exception" do
      Stripe::Charge.stub(:create).and_raise(Stripe::InvalidRequestError.new("blah", 3))
      Stripe::InvalidRequestError.stub(:message).and_return("blah")
      @purchase.save_with_payment.should == false
    end
    
    it "should not create a new purchase if it cannot update the lettre order" do
      @purchase.lettre_order.stub(:save).and_return(false)
      Stripe::Charge.stub(:create).and_return(stripe_api_response)
      expect {
        @purchase.save_with_payment
      }.to_not change(Purchase, :count)
    end
    
    it "should not change the lettre order" do
      @purchase.lettre_order.stub(:save).and_return(false)
      Stripe::Charge.stub(:create).and_return(stripe_api_response)
      expect {
        @purchase.save_with_payment
      }.to_not change(@lettre_order.reload, :delivery_status)
    end
  end
end
