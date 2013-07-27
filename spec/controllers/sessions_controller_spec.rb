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
          post :create, user: FactoryGirl.attributes_for(:user)
          session[:user_id].should_not == nil
        end
        it "redirects to root_path" do
          post :create, user: FactoryGirl.attributes_for(:user)
          response.code.should == "302"
          response.should redirect_to(root_path)
        end
      end
    end

    context "when the user has an invalid email" do
      it "should not sign the user in" do
        post :create, user: FactoryGirl.attributes_for(:user_with_invalid_login)
        session[:user_id].should == nil
      end
      it "render the new view" do
        post :create, user: FactoryGirl.attributes_for(:user_with_invalid_login)
        response.should render_template(:new)
      end
    end

  end
end
