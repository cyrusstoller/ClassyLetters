require "spec_helper"

describe PurchasesController do
  describe "routing" do

    it "routes to #show" do
      get("lettre_orders/1/purchase").should route_to("purchases#show", :lettre_order_id => "1")
    end

    it "routes to #new" do
      get("lettre_orders/1/purchase/new").should route_to("purchases#new", :lettre_order_id => "1")
    end

    # it "routes to #edit" do
    #   get("lettre_orders/1/purchase/edit").should route_to("purchases#edit", :lettre_order_id => "1")
    # end

    it "routes to #create" do
      post("lettre_orders/1/purchase").should route_to("purchases#create", :lettre_order_id => "1")
    end

    # it "routes to #update" do
    #   put("lettre_orders/1/purchase").should route_to("purchases#update", :lettre_order_id => "1")
    # end

    # it "routes to #destroy" do
    #   delete("lettre_orders/1/purchase").should route_to("purchases#destroy", :lettre_order_id => "1")
    # end

  end
end
