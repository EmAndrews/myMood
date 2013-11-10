require 'spec_helper'
require 'homepage_controller'

describe Homepage do

  # -- SPECS FOR THE SIGN UP METHOD ----------------------------
  describe "signup" do
    it "should redirect home" do
      post :index
      response.should redirect_to(home_path)
    end
    it "should redirect to signup" do
      post :signup
      response.should redirect_to(signup_path)
    end
  end

  # -- SPECS FOR CREATING A USER FROM SIGN UP PAGE --------------
  describe "create user" do
    it "should not redirect with unmatching passwords" do
      get :login, :password => "aaa", :confirm_password => "aa"
      response.should_not redirect
    end
    it "should redirect with matching passwords" do
      get :login, :password => "aaa", :confirm_password => "aaa"
      response.should redirect_to(session_path)
    end
  end

  # -- SPECS FOR LOGGING IN AFTER SIGNING UP -------------------
  describe "logging in" do
    it "should redirect to login with valid info" do
      get :login, :phone_number => "555-555-5555". :password => "555"
      # ^^ This user really likes the number 5.
      response.should redirect
    end
    it "should not redirect to login with invalid info" do
      get :login, :phone_number => "555-555-5555". :password => "aaa"
      response.should_not redirect
    end
  end


  # -- SPECS FOR HELPER FUNCTIONS IN HOMEPAGE ------------------
  describe "passwords_match?" do
    it "should return true if passwords match" do
      passwords_match?("aaa", "aaa").should == true
    end
    it "should return false if passwords don't match" do
      passwords_match?("aaa", "aa").should == false
    end
  end
end
