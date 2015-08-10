require 'spec_helper'

describe ErrorsController, type: :controller do

  describe "GET #error_404" do
    it "renders the error_404 template" do
      get :error_404, not_found: '/an_invalid_path'
      response.should render_template('error_404')
    end
  end

end
