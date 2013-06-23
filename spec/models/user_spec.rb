require 'spec_helper'

describe User do
  describe "mass assignment" do
    [:email, :name, :access_token, :uid, :provider, :photo_url].each do |attr|
      it { should allow_mass_assignment_of(attr) }
    end
  end

  describe "validations" do
    describe "of presence" do
      [:email, :access_token, :name, :uid].each do |attr|
        it { should validate_presence_of(attr) }
      end
    end

    describe "of uniqueness" do
      it { should validate_uniqueness_of(:email) }
    end
  end

  describe ".find_or_create_with_omniauth(auth)" do
    let(:auth) { OmniAuth.config.mock_auth[:facebook] }

    it "creates a new user" do
      expect do
        User.find_or_create_with_omniauth(auth)
      end.to change { User.count }.by(1)
    end

    context "with a new user" do
      subject { User.find_or_create_with_omniauth(auth) }
      its(:name) { should eq("Joe Bloggs") }
      its(:email) { should eq("joe@bloggs.com") }
      its(:access_token) { should eq("ABCDEF") }
      its(:uid) { should eq("1234567") }
      its(:provider) { should eq("facebook") }
      its(:photo_url) { should eq("http://graph.facebook.com/1234567/picture?type=square") }
    end

    context "with an existing user" do
      let!(:user) { create(:user, uid: "1234567") }

      subject { User.find_or_create_with_omniauth(auth) }

      it "returns the user" do
        subject.should eq(user)  
      end

      it "doesn't create a new user" do
        expect do
          subject
        end.to_not change { User.count }
      end

      its(:name) { should eq("Joe Bloggs") }
      its(:email) { should eq("joe@bloggs.com") }
      its(:access_token) { should eq("ABCDEF") }
      its(:uid) { should eq("1234567") }
      its(:provider) { should eq("facebook") }
      its(:photo_url) { should eq("http://graph.facebook.com/1234567/picture?type=square") }      
    end
  end
end
