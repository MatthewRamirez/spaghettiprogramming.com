class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionHelper
  include ApplicationHelper
  require 'will_paginate/array'
  require 'pp'

end
