class ShasController < ApplicationController

	#SETTINGS = Settings.first

	def new
		@sha = Sha.new
	end

	def test
		
		id = params[:id]

		@history = Sha.last(5).reverse
		record = Sha.find(139)

		`camget -o /home/nick/rails/memocom.org/app/assets/audios/temp -contents #{record.content}`
		
		file = Dir.glob("app/assets/audios/temp/*")
		File.rename(file[0], "app/assets/audios/temp/#{record.filename}")
		file = Dir.glob("app/assets/audios/temp/*")
		array = file[0].split('/')
		loc = array[3] + "/" + array[4]

		@music = loc
	end

	def create

		file_params = params[:sha][:file_input]
		desc = params[:sha][:description]

		logger.debug "file_methods = #{file_params.methods}"

		if file_params.instance_of? Array

			file_params.each do |file|

				@sha = Sha.new
				ft = Filetype.new
				camput = `camput file --permanode #{file.tempfile.path}`
				camput_array = camput.split("\n")
				filename = file.original_filename
				extension = filename.split('.')[1]
				filetype = ft.get_filetype(extension)

				@sha[:permanode] = camput_array[2]
				@sha[:content] = camput_array[0]
				@sha[:filename] = filename
				@sha[:extension] = extension
				@sha[:filetype] = ft.get_filetype(extension)
				@sha[:icon] = "96x96/#{filetype}.png"
				@sha[:private] = true
				@sha[:public] = true
				@sha[:description] = desc
				if filetype == 'image'
					@sha[:thumbnail] = @sha.get_thumbnail(camput_array[2])
				else
					@sha[:thumbnail] = "Icons/96x96/96x96_#{filetype}"
				end
				@sha[:download] = @sha.random_string()
				@sha[:auth] = @sha.random_string() + " " + @sha.random_string() + " " + @sha.random_string()

				@sha.save

			end

		else

			@sha = Sha.new
			ft = Filetype.new
			camput = `camput file --permanode #{file_params.tempfile.path}`
			camput_array = camput.split("\n")
			filename = file_params.original_filename
			extension = filename.split('.')[1]
			filetype = ft.get_filetype(extension)

			@sha[:permanode] = camput_array[2]
			@sha[:content] = camput_array[0]
			@sha[:filename] = filename
			@sha[:extension] = extension
			@sha[:filetype] = ft.get_filetype(extension)
			@sha[:icon] = "96x96/#{filetype}.png"
			@sha[:private] = true
			@sha[:public] = true
			@sha[:description] = desc
			if filetype == 'image'
				@sha[:thumbnail] = @sha.get_thumbnail(camput_array[2])
			else
				@sha[:thumbnail] = "Icons/96x96/96x96_#{filetype}"
			end
			@sha[:download] = @sha.random_string()
			@sha[:auth] = @sha.random_string() + " " + @sha.random_string() + " " + @sha.random_string()

			@sha.save

		end

		redirect_to storagedb_path

	end

	def change

		id = params[:id]
		filename = params[:filename]
		description = params[:desc]
		delete = params[:delete]

		logger.debug "params[:delete].class = #{params[:delete].class}"

		sha = Sha.find(id)
		if delete == "edit"
			sha.filename = filename
			sha.description = description
			sha.save
		elsif delete == "true"
			sha.delete
		end

		redirect_to storagedb_path

	end

	def index
		@active = "home"
		@sha = Sha.new
		@history = Sha.last(5).reverse
	end

	def status

		flash[:notice] = t(:hello_flash)

		@data_for_filetype_piechart = Sha.group('filetype').count
		
		@used_space = `du -s -m /home/nick/var/camlistore/blobs`.gsub(/[^\d]/, '').to_i
		stat = Sys::Filesystem.stat("/")
		@free_space = stat.block_size * stat.blocks_available / 1024 / 1024

		mem_results = `free -m`

		arr = mem_results.split(' ')

		@numbers_only = arr.map {|x| Integer(x) rescue nil }.compact

		@active = "status"
		@sha = Sha.new
		@history = Sha.last(5).reverse
	end

	def help
		@sha = Sha.new
		@history = Sha.last(5).reverse
	end

	def settings
		@sha = Sha.new
		@history = Sha.last(5).reverse
	end

	def storage

		@active = "storage"

		@thumbnail_size = Settings.first.thumbnail_size

		search = params[:s]
		filter = params[:f]
		if !filter.nil?
			filter = filter.split(' ')
		end

		if !params[:sort].nil?
			sort_params = params[:sort]
			order = sort_params.split('-')[0]
			type = sort_params.split('-')[1]
		end

		if order.nil?
			order = "created_at"
		end
		if type.nil?
			type = "desc"
		end

		@sha = Sha.new
		@all = @sha.filter_and_search(filter, search, order, type)


		@history = Sha.last(5).reverse

		@ip = Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address
		@filter = Sha.select(:filetype).distinct

		@f = filter
		@fi = params[:f]
		@s = search
		@z = params[:size]

	end

	def public

		key = params[:d]

		result = Sha.where('download LIKE ?', "%#{key}%").first

		if result.nil?
			redirect_to storagedb_path
		else
			camliContent = result.content
			filename = result.filename

			send_data `camget -contents #{camliContent}`, :filename => filename
		end

	end



	private

		def sha_params
			params.require(:sha).permit(:permanode, :content, :filename, :extension,
			 :filetype, :icon, :private, :public, :thumbnail, :download, :auth)
		end


end
