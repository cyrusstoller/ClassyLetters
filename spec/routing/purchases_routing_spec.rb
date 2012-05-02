require "spec_helper"

describe PurchasesController do
  describe "routing" do

    it "routes to #show" do
      get("letter_orders/1/purchase").should route_to("purchases#show", :letter_order_id => "1")
    end

    it "routes to #new" do
      get("letter_orders/1/purchase/new").should route_to("purchases#new", :letter_order_id => "1")
    end

    # it "routes to #edit" do
    #   get("letter_orders/1/purchase/edit").should route_to("purchases#edit", :letter_order_id => "1")
    # end

    it "routes to #create" do
      post("letter_orders/1/purchase").should route_to("purchases#create", :letter_order_id => "1")
    end

    # it "routes to #update" do
    #   put("letter_orders/1/purchase").should route_to("purchases#update", :letter_order_id => "1")
    # end

    # it "routes to #destroy" do
    #   delete("letter_orders/1/purchase").should route_to("purchases#destroy", :letter_order_id => "1")
    # end

  end
end
