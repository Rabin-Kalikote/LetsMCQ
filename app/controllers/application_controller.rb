class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_path, :notice => "'404' Page not found! The page might have been broken or removed."
  end
end
