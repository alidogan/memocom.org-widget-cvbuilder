class FileController < ApplicationController
  respond_to :html, :js, :xml, :json
  layout false
	  
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