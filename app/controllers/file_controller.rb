class FileController < ApplicationController
  layout false

  # Create json of angular gridster positions	  
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

  # Create json of to do list notes  
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