require 'rails_helper'

describe "View the Home Page", :type => :request do

    it "displays the blog name" do
      get "/home"
      expect(response).to render_template(:layout => 'layouts/application')
      expect(response.body).to include('Spaghetti Programming')
    end

end
