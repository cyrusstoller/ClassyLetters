require "spec_helper"

describe LettreOrdersController do
  describe "routing" do

    it "routes to #index" do
      get("/lettre_orders").should route_to("lettre_orders#index")
    end

    it "routes to #new" do
      get("/lettre_orders/new").should route_to("lettre_orders#new")
    end

    it "routes to #show" do
      get("/lettre_orders/1").should route_to("lettre_orders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lettre_orders/1/edit").should route_to("lettre_orders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lettre_orders").should route_to("lettre_orders#create")
    end

    it "routes to #update" do
      put("/lettre_orders/1").should route_to("lettre_orders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lettre_orders/1").should route_to("lettre_orders#destroy", :id => "1")
    end

  end
end
