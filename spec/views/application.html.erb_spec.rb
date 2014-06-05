require 'spec_helper'

describe "rendering the application layout" do

  it "displays the blog name" do
    render :template => "layouts/application.html.erb"

    expect(rendered).to match /Spaghetti Programming/
  end
end
