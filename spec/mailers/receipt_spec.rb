require "spec_helper"

describe Receipt do
  before(:each) do
    @user = Factory(:user)
    @letter_order = Factory(:letter_order, :user_id => @user.id, :delivery_status => 2)
    @purchase = Factory(:purchase, :letter_order_id => @letter_order.id)
  end
  
  describe "send text to me when a new purchase comes in" do
    it "should be successful when sending a text to me" do
      Receipt.send_text(@purchase).deliver
      ActionMailer::Base.deliveries.last.to.should == ["#{ENV["ADMIN_TXT_NUMBER"]}@txt.att.net"]
    end
  end

  describe "send an email receipt when the payment has been processed" do
    it "should be successful when sending a receipt" do
      Receipt.send_receipt(@purchase).deliver
      ActionMailer::Base.deliveries.last.to == [@user.email]
    end
  end
end