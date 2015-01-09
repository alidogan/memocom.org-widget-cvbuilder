class BlobsController < ApplicationController

	def create		
		file_params = params[:blob][:file_input]

		camli = Camli.new(file_params)

		redirect_to :back
	end

	def index

		c = Camli.new()

		@blob = Blob.new
		c.make_lists()
		last_uploads = c.get_last_n_uploads(5)
		@filenames = last_uploads[0]
		@icons = last_uploads[1]

	end

	def storage

		filter = params[:t]

		@blob = Blob.new

		c = Camli.new()

		
		#Used to create the values for the filter sub-menu
		#@filetypes = c.get_filetypes_for_filter()

		#@extensions = c.get_extensions_for_filter(@filetypes)

		@data = c.show_everything(filter)

		#Gets the ip for the thumbnails
		@ip = Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address

		if !@data.nil?
			@filenames = @data[0].reverse
			@icons = @data[1].reverse
			@thumbnails = @data[2].reverse
			@links = @data[3].reverse
			@keys = @data[4].reverse
		end

		last_uploads = c.get_last_n_uploads(5)
		@filenames_n = last_uploads[0]
		@icons_n = last_uploads[1]

	end

	def show
		
	end

	def public

		key = params[:d]

		c = Camli.new('')

		search_result = c.download(key,'public')

		if search_result.nil?
			redirect_to root_path
		else
			sha1 = search_result[0]
			filename = search_result[1]
			
			if !sha1.nil?
				send_data `camget -contents #{sha1}`, :filename => filename
			else
				redirect_to root_path
			end
		end

	end

	def private

		@key = params[:d]

		c = Camli.new('')

		sha = c.get_sha_from_attr_value('download', @key)

		search_result = c.download(@key, 'private')

		if search_result.nil?
			redirect_to root_path
		else
			@filename=c.get_permanode_attributes(sha, 'filename')[0]
		end

	end

	def private_check_and_send

		auth = params[:auth]
		key = params[:key]

		c = Camli.new

		permanode_sha = c.get_sha_from_attr_value('download', key)

		search_result = c.download(key, 'private')

		if search_result.nil?
			redirect_to '/upload'
		else
			sha1 = search_result[0]
			filename = search_result[1]

			logger.debug "sha1, auth = #{sha1}, #{auth}"

			valid = c.check_auth(permanode_sha, auth)

			if valid
				send_data `camget -contents #{sha1}`, :filename => filename
			else
				redirect_to '/upload'
			end
		end
	end

	def about

		@blob = Blob.new
		c = Camli.new

		last_uploads = c.get_last_n_uploads(5)
		@filenames_n = last_uploads[0]
		@icons_n = last_uploads[1]

	end
end
