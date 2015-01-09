class FileController < ApplicationController
  respond_to :html, :js, :xml, :json
  layout false

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
  
	def create
    render nothing: true
  	Dir.chdir("public") do
  		puts Dir.pwd
  		position = params['_json']
      if position == nil
        json = "[]"
      else
  		  json = position.to_json
      end
  		File.write('dashboard.json', json)
    end
  end

  def todo
    render nothing: true
    Dir.chdir("public") do
      puts Dir.pwd
      position = params['_json']
      if position == nil
        json = "[]"
      else
        json = position.to_json
      end
      File.write('todo.json', json)
    end
  end
  
end