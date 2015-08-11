require 'rails_helper'

describe "layouts/application" do

  it "displays the blog name" do
    render
    expect(rendered).to match /Spaghetti Programming/
  end
end
