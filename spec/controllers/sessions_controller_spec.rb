require 'rails_helper'

describe SessionsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  describe "POST #destroy" do
    it "signs the user out" do
      session[:user_id] = 1
      post :destroy
      expect(session[:user_id]).to eq(nil)
    end
    it "redirects to root_path" do
      post :destroy
      expect(response.code).to eq("302")
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    context "when the user has a valid email" do
      context "and the user exists" do
        it "signs the user in" do
          user
          post :create, user: FactoryGirl.attributes_for(:user)
          expect(session[:user_id]).to_not eq(nil)
        end
        it "redirects to root_path" do
          user
          post :create, user: FactoryGirl.attributes_for(:user)
          expect(response.code).to eq("302")
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "when the user has an invalid email" do
      it "should not sign the user in" do
        post :create, user: FactoryGirl.attributes_for(:user_with_invalid_login)
        expect(session[:user_id]).to eq(nil)
      end
      it "render the new view" do
        post :create, user: FactoryGirl.attributes_for(:user_with_invalid_login)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #new" do
    context "when signed out" do
      it "renders the new view" do
        get :new
        expect(response).to render_template('new')
      end
    end
    context "when signed in" do
      it "redirects to root path" do
        session[:user_id] = user.id
        get :new
        expect(response.code).to eq("302")
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
