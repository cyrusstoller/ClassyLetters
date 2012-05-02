require "spec_helper"

describe LetterOrdersController do
  describe "routing" do

    it "routes to #index" do
      get("/letter_orders").should route_to("letter_orders#index")
    end

    it "routes to #new" do
      get("/letter_orders/new").should route_to("letter_orders#new")
    end

    it "routes to #show" do
      get("/letter_orders/1").should route_to("letter_orders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/letter_orders/1/edit").should route_to("letter_orders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/letter_orders").should route_to("letter_orders#create")
    end

    it "routes to #update" do
      put("/letter_orders/1").should route_to("letter_orders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/letter_orders/1").should route_to("letter_orders#destroy", :id => "1")
    end

  end
end
