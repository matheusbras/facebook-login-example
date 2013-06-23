# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SessionsController do
  let!(:user) { create(:user, :provider => 'facebook', :uid => '12345') }

  describe "GET create" do
    def do_action
      get :create, :provider => 'facebook'
    end

    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it "sets user id on session" do
      other_user = create(:user, :provider => 'facebook', :uid => '1234567')
      do_action
      session[:user_id].should == other_user.id
    end

    it "should redirect to root url" do
      do_action
      response.should redirect_to(root_url)
    end

    it "creates a new user" do
      expect do
        do_action
      end.to change { User.count }.by(1)
    end
  end

  describe "GET failure" do
    def do_action
      get :failure
    end

    it "redirects to root url" do
      do_action
      response.should redirect_to(root_url)
    end
  end

  describe "GET destroy" do
    def do_action
      get :destroy
    end

    before do
      session[:user_id] = "1"
    end

    it "should nuliffy user_id on sessions" do
      do_action
      session[:user_id].should be_nil
    end

    it "should redirect to root url" do
      do_action
      response.should redirect_to(root_url)
    end
  end
end
