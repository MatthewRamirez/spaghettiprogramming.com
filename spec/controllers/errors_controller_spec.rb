require 'rails_helper'

describe ErrorsController, type: :controller do

  describe "GET #error_404" do
    it "renders the error_404 template" do
      get :error_404, not_found: '/an_invalid_path'
      expect(response).to render_template('error_404')
    end
  end

end
