require 'spec_helper'

describe PurchasedOrdersController do
  render_views
  
  before(:each) do
    @user = Factory(:user, :admin => true)
    sign_in @user
  end
  
  describe "GET 'index'" do
    it "should redirect when there are no lettre orders" do
      get :index
      response.should redirect_to(root_path)
    end
    
    it "should redirect when there are no lettre orders" do
      Factory(:lettre_order)
      get :index
      response.should redirect_to(root_path)
    end
    
    it "should be successful when there is a purchased lettre order" do
      Factory(:lettre_order, :delivery_status => 1)
      get :index
      response.should be_successful
    end
    
    it "should redirect if given a legitimate uuid" do
      f = Factory(:lettre_order, :delivery_status => 1)
      uuid = f.uuid
      get :index, :uuid => uuid
      response.should redirect_to(purchased_order_path(uuid))
    end
    
    it "should not redirect if there is an invalid uuid" do
      Factory(:lettre_order, :delivery_status => 1)
      get :index, :uuid => 3
      response.should be_successful
    end
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      lettre_order = Factory(:lettre_order, :delivery_status => 1)
      get :show, :id => lettre_order.to_param
      response.should be_successful
    end
    
    it "should redirect back to the index action if the delivery status is still a draft" do
      lettre_order = Factory(:lettre_order, :delivery_status => 0)
      get :show, :id => lettre_order.to_param
      response.should redirect_to(purchased_orders_path)
    end
  end
  
  describe "PUT 'fulfilled'" do
    it "should change the delivery_status of the lettre_order" do
      lettre_order = Factory(:lettre_order, :delivery_status => 0)
      put :fulfilled, :id => lettre_order.to_param, :delivery_status => 1
      lettre_order.reload
      lettre_order.delivery_status.should == 1
    end
    
    it "should change the delivery_status of the lettre_order" do
      lettre_order = Factory(:lettre_order, :delivery_status => 0)
      put :fulfilled, :id => lettre_order.to_param, :delivery_status => 1
      response.should redirect_to(purchased_orders_path)
    end
  end
end
