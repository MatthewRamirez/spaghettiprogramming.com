require 'spec_helper'

describe ErrorsController do

  describe "GET 'error_404'" do
    context "when the page does not exist" do
      it "returns 404" do
        lambda{
          get '/page_that_doesnt_exist'
        }.should raise_error(ActionController::RoutingError)
      end

      it "renders the 404 page"
    end

  end

  describe "GET 'error_500'" do
    context "when there is an error raised" do
      it "returns 500"
      it "renders the 500 page"
    end
  end

end
