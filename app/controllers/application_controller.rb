class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :null_session

	before_action :set_locale
	before_filter :make_pie_chart
	
	 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options(options={})
  		logger.debug "default_url_options is passed options: #{options.inspect}\n"
  		{ locale: I18n.locale }
	end
  
end
