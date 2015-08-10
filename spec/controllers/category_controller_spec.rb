require 'spec_helper'

describe CategoriesController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }

  describe "GET #index" do
    context "when signed in" do
      it "gets a list of categories" do
        session[:user_id] = user.id
        get :index
        assigns(:categories).should eq(Category.all)
      end

      it "returns 200" do
        session[:user_id] = user.id
        get :index
        response.code.should == "200"
      end
    end

    context "when signed out" do
      it "redirects to root_path" do
        get :index
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested category to @category" do
      get :show, :id => category
      assigns(:category).should eq(category)
    end
  end

  describe "GET #new" do
    context "when signed in" do
      it "assigns a new category to @category" do
        session[:user_id] = user.id
        get :new
        assigns(:category).should be_an_instance_of(Category)
      end
      it "renders the :new view" do
        session[:user_id] = user.id
        get :new
        response.should render_template(:new)
      end
    end
    context "when signed out" do
      it "redirects to root_path" do
        get :new
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    context "when signed in" do
      it "assigns the selected category to @category" do
        session[:user_id] = user.id
        get :edit, :id => category
        assigns(:category).should eq(category)
      end
      it "renders the :edit view" do
        session[:user_id] = user.id
        get :edit, :id => category
        response.should render_template(:edit)
      end
    end
    context "when signed out" do
      it "redirects to root_path" do
        get :edit, :id => category
        response.code.should == "302"
        response.should redirect_to(root_path)
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
          response.should render_template :new
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
          response.should redirect_to categories_path
        end
      end
    end
    context "when signed out" do
      it "should redirect to root_path" do
        post :create
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end
  end

  describe "POST #update" do
    context "when signed in" do
      it "should update the name of the category" do
        session[:user_id] = user.id
        put :update, :id => category.id, :category => {:name => 'newname'}
        category.reload
        category.name.should eq('newname')
      end
      it "redirects to the categories path" do
        session[:user_id] = user.id
        put :update, :id => category.id, :category => {:name => 'newname'}
        response.should redirect_to categories_path
      end
    end
    context "when signed out" do
      it "should redirect to root_path" do
        post :update, :id => category.id
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end
  end

end
