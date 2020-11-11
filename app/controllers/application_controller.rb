class ApplicationController < ActionController::Base
  # add_flash_types :error, :success
  before_action :authenticate_user!
end
