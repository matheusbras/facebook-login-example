require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "facebook callback" do
      get("/auth/facebook/callback").should route_to("sessions#create", :provider => "facebook")
      auth_callback_path("facebook").should == "/auth/facebook/callback"
    end

    it "auth failure" do
      get("/auth/failure").should route_to("sessions#failure")
      auth_failure_path.should == "/auth/failure"
    end

    it "facebook callback" do
      get("/logout").should route_to("sessions#destroy")
      logout_path.should == "/logout"
    end
  end
end
