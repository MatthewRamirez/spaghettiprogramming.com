require 'spec_helper'

describe UsersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  describe "GET #edit" do
    context "when signed out" do
      it "redirects_to root_path" do
        get :edit, :id => user.id
        expect(response).to redirect_to(root_path)
      end
    end
    context "when signed in" do
      it "should render the edit view" do
        session[:user_id] = user.id
        get :edit, :id => user.id
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "PUT #update" do
    context "when signed out" do
      it "redirects_to root_path" do
        put :update, :id => user.id
        expect(response).to redirect_to(root_path)
      end
    end
    context "when signed in" do
      it "should update the email of the user" do
        session[:user_id] = user.id
        put :update, :id => user.id, :user => FactoryGirl.attributes_for(:user_with_changed_email)
        user.reload
        expect(user.email).to eq(FactoryGirl.attributes_for(:user_with_changed_email)[:email])
      end
    end

  end
end
