class PagesController < ApplicationController
  def show
    render(params[:id] || 'home')   
  end
end
