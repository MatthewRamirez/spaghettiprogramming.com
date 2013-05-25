require 'spec_helper'

describe SessionsController do

  describe "POST #destroy" do
    it "signs the user out" do
      session[:user_id] = 1
      post :destroy
      session[:user_id].should == nil
    end
    it "redirects to root_path" do
      post :destroy
      response.code.should == "302"
      response.should redirect_to(root_path)
    end
  end

  describe "POST #create" do
    context "when the user has a valid email" do
      context "and the user exists" do
        it "signs the user in" do
          request.env["omniauth.auth"] = FactoryGirl.attributes_for(:user_valid_oauth_params)[:oauth_params]
          post :create
          session[:user_id].should_not == nil
        end
        it "redirects to root_path" do
          request.env["omniauth.auth"] = FactoryGirl.attributes_for(:user_valid_oauth_params)[:oauth_params]
          post :create
          response.code.should == "302"
          response.should redirect_to(root_path)
        end

      end
      context "and the user does not exist" do
        it "creates the user" do
          request.env["omniauth.auth"] = FactoryGirl.attributes_for(:user_valid_oauth_params)[:oauth_params]
          expect{
            post :create
          }.to change(User, :count).by(1)
        end
        it "redirects to root_path" do
          request.env["omniauth.auth"] = FactoryGirl.attributes_for(:user_valid_oauth_params)[:oauth_params]
          post :create
          response.code.should == "302"
          response.should redirect_to(root_path)
        end
      end

    end

    context "when the user has an invalid email" do
      it "should not sign the user in" do
        request.env["omniauth.auth"] = FactoryGirl.attributes_for(:user_invalid_oauth_params)[:oauth_params]
        post :create
        session[:user_id].should == nil
      end
      it "redirects to root_path" do
        request.env["omniauth.auth"] = FactoryGirl.attributes_for(:user_valid_oauth_params)[:oauth_params]
        post :create
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end

  end
end
