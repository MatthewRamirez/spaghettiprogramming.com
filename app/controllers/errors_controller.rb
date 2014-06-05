class ErrorsController < ApplicationController
  def error_404
    @not_found_path = params[:not_found]
    render( :file => '/errors/error_404', :layout => false)
  end

end
