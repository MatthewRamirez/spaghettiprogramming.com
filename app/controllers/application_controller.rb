class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionHelper
  include ApplicationHelper

  unless Rails.env == 'development'
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render file: "/errors/error_#{status}", layout: false, status: status }
      format.all { render nothing: true, status: status }
    end
  end

end
