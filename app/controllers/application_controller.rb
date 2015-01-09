class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :null_session

	before_action :set_locale
	before_filter :make_pie_chart
	
	def make_pie_chart
		  require 'gruff'
  		a = Sha.group("filetype").count

  		g = Gruff::Pie.new
  		g.title = 'Filetypes'
 
  		a.each do |key, value|
  		  puts g.data(key, a[key])
  		end

		  g.write('app/assets/images/pie.png')
	end
	
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options(options={})
  		logger.debug "default_url_options is passed options: #{options.inspect}\n"
  		{ locale: I18n.locale }
	end
  
end
