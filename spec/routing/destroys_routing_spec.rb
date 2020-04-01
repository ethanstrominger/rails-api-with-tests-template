require "rails_helper"

RSpec.describe DestroysController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/destroys").to route_to("destroys#index")
    end


    it "routes to #show" do
      expect(:get => "/destroys/1").to route_to("destroys#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/destroys").to route_to("destroys#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/destroys/1").to route_to("destroys#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/destroys/1").to route_to("destroys#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/destroys/1").to route_to("destroys#destroy", :id => "1")
    end

  end
end
