require "spec_helper"

describe PurchasedOrdersController do
  describe "routing" do

    it "routes to #index" do
      get("/purchased_orders").should route_to("purchased_orders#index")
    end

    it "routes to #show" do
      get("/purchased_orders/1").should route_to("purchased_orders#show", :id => "1")
    end

  end
end
