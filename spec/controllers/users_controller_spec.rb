require 'spec_helper'

describe UsersController do

  user = User.find_by_email('user@email.com')

  describe "GET #edit" do
    context "when signed out" do
      it "redirects_to root_path" do
        get :edit, :id => 1
        response.should redirect_to(root_path)
      end
    end
    context "when signed in" do
      it "should render the edit view" do
        session[:user_id] = user
        get :edit, :id => user
        response.should render_template(:edit)
      end
    end
  end

  describe "GET #update" do
    context "when signed out" do
      it "redirects_to root_path" do
        put :update, :id => user
        response.should redirect_to(root_path)
      end
    end
    context "when signed in" do
      it "should update the email of the user" do
        session[:user_id] = user
        put :update, :id => user.id, :user => FactoryGirl.attributes_for(:user_with_changed_email)
        user.reload
        user.email.should eq(FactoryGirl.attributes_for(:user_with_changed_email)[:email])
      end
    end

  end
end
