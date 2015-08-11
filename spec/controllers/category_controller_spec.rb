require 'spec_helper'

describe CategoriesController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }

  describe "GET #index" do
    context "when signed in" do
      it "gets a list of categories" do
        session[:user_id] = user.id
        get :index
        expect(assigns(:categories)).to eq(Category.all)
      end

      it "returns 200" do
        session[:user_id] = user.id
        get :index
        expect(response.code).to eq("200")
      end
    end

    context "when signed out" do
      it "redirects to root_path" do
        get :index
        expect(response.code).to eq("302")
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested category to @category" do
      get :show, :id => category
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET #new" do
    context "when signed in" do
      it "assigns a new category to @category" do
        session[:user_id] = user.id
        get :new
        expect(assigns(:category)).to be_an_instance_of(Category)
      end
      it "renders the :new view" do
        session[:user_id] = user.id
        get :new
        expect(response).to render_template(:new)
      end
    end
    context "when signed out" do
      it "redirects to root_path" do
        get :new
        expect(response.code).to eq("302")
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    context "when signed in" do
      it "assigns the selected category to @category" do
        session[:user_id] = user.id
        get :edit, :id => category
        expect(assigns(:category)).to eq(category)
      end
      it "renders the :edit view" do
        session[:user_id] = user.id
        get :edit, :id => category
        expect(response).to render_template(:edit)
      end
    end
    context "when signed out" do
      it "redirects to root_path" do
        get :edit, :id => category
        expect(response.code).to eq("302")
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "when signed in" do
      context "with an empty name" do
        it "does not save the new category" do
          session[:user_id] = user.id
          expect{
            post :create, category: FactoryGirl.attributes_for(:category, :name => nil)
          }.to_not change(Category, :count)
        end

        it "renders the :new view" do
          session[:user_id] = user.id
          post :create, category: FactoryGirl.attributes_for(:category, :name => nil)
          expect(response).to render_template(:new)
        end
      end

      context "with valid category attributes" do
        it "saves the new category" do
          session[:user_id] = user.id
          expect{
            post :create, category: FactoryGirl.attributes_for(:category)
          }.to change(Category, :count).by(1)
        end

        it "redirects to the categories path" do
          session[:user_id] = user.id
          post :create, category: FactoryGirl.attributes_for(:category)
          expect(response).to redirect_to(categories_path)
        end
      end
    end
    context "when signed out" do
      it "should redirect to root_path" do
        post :create
        expect(response.code).to eq("302")
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #update" do
    context "when signed in" do
      it "should update the name of the category" do
        session[:user_id] = user.id
        put :update, :id => category.id, :category => {:name => 'newname'}
        category.reload
        expect(category.name).to eq('newname')
      end
      it "redirects to the categories path" do
        session[:user_id] = user.id
        put :update, :id => category.id, :category => {:name => 'newname'}
        expect(response).to redirect_to(categories_path)
      end
    end
    context "when signed out" do
      it "should redirect to root_path" do
        post :update, :id => category.id
        expect(response.code).to eq("302")
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
