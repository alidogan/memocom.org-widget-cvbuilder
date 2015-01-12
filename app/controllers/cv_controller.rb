class CvController < ApplicationController
  def index
  end

	# Create json files of personalia	 
	def personalia
      render nothing: true
      directory_name = "public/cv"
	  Dir.mkdir(directory_name) unless File.exists?(directory_name)

  		Dir.chdir("public/cv") do
	  		puts Dir.pwd
	  		json1 = params.to_json
	  		json = "[" + json1 + "]"
	  		File.write('personalia.json', json)
	  		File.write('personalia_read.json', json1)
  		end
  	end

	# Create json files of languages	 
  	def talen
      render nothing: true
      directory_name = "public/cv"
	  Dir.mkdir(directory_name) unless File.exists?(directory_name)

  		Dir.chdir("public/cv") do
	  		puts Dir.pwd
	  		position = params['Talen']
			if position == nil
				json = "[]"
			else
				json = position.to_json
				json_read = params.to_json
			end
	  		File.write('talen.json', json)
	  		File.write('talen_read.json', json_read)
  		end
  	end

	# Create json files of educations	
  	def opleidingen
      render nothing: true
      directory_name = "public/cv"
	  Dir.mkdir(directory_name) unless File.exists?(directory_name)

  		Dir.chdir("public/cv") do
	  		puts Dir.pwd
	  		position = params['Opleidingen']
			if position == nil
				json = "[]"
			else
				json = position.to_json
				json_read = params.to_json
			end
	  		File.write('opleidingen.json', json)
	  		File.write('opleidingen_read.json', json_read)
  		end
  	end

	# Create json files of work experience	 
  	def werkervaring
		render nothing: true
		directory_name = "public/cv"
		Dir.mkdir(directory_name) unless File.exists?(directory_name)

		Dir.chdir("public/cv") do
			puts Dir.pwd
			position = params['Werkervaring']
			if position == nil
				json = "[]"
			else
				json = position.to_json
				json_read = params.to_json
			end
			File.write('werkervaring.json', json)
			File.write('werkervaring_read.json', json_read)
		end
	end
  	
	# History in the navbar
	def index
		@active = "home"
		@sha = Sha.new
		@history = Sha.last(5).reverse
	end

end