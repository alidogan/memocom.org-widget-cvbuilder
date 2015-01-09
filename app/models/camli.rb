class Camli

	attr_accessor :filecontent, :metadata, :permanode, :filename, :filetype, :download_string	

	#If a file is passed to the constructor, the file gets uploaded, and attributes are set.
	def initialize(*args)

		if args[0].instance_of?(ActionDispatch::Http::UploadedFile)

			file_params = args[0]

			sha1_collection = `camput file --permanode #{file_params.tempfile.path}`
			sha1_array = sha1_collection.split("\n")

			@permanode = sha1_array[2]
			@filecontent = sha1_array[0]

			filename = remove_spaces(file_params.original_filename)
			file_extension = filename.split('.')[1]
			filetype = get_filetype(file_extension)

			set_attributes("filename", filename)
			set_attributes("file_extension", file_extension)
			set_attributes("filetype", filetype)
			set_attributes(get_sha_from_attr_value('title', 'all_shas'), "list", @permanode)
			set_attributes("auth", random_string())
			set_attributes("auth", random_string())
			set_attributes("auth", random_string())
			set_attributes("public", "true")
			set_attributes("private", "true")

			if filetype == "image"
				get_thumbnail(@permanode)
			end

			add_sha_to_extension_list(@permanode, file_extension)
			add_sha_to_extension_list(@permanode, filetype)

			begin
				random_string = random_string()
			end while does_attr_value_exist?('download', random_string)

			set_attributes("download", random_string)
			set_attributes("icon", "96x96/#{filetype}.png")

		elsif args[0].instance_of?(Array)

			args[0].each do |file_params|

				sha1_collection = `camput file --permanode #{file_params.tempfile.path}`
				sha1_array = sha1_collection.split("\n")

				@permanode = sha1_array[2]
				@filecontent = sha1_array[0]

				filename = remove_spaces(file_params.original_filename)
				file_extension = filename.split('.')[1]
				filetype = get_filetype(file_extension)

				set_attributes("filename", filename)
				set_attributes("file_extension", file_extension)
				set_attributes("filetype", filetype)
				set_attributes(get_sha_from_attr_value('title', 'all_shas'), "list", @permanode)
				set_attributes("auth", random_string())
				set_attributes("auth", random_string())
				set_attributes("auth", random_string())
				set_attributes("public", "true")
				set_attributes("private", "true")

				if filetype == "image"
					get_thumbnail(@permanode)
				end

				add_sha_to_extension_list(@permanode, file_extension)
				add_sha_to_extension_list(@permanode, filetype)

				begin
					random_string = random_string()
				end while does_attr_value_exist?('download', random_string)

				set_attributes("download", random_string)
				set_attributes("icon", "96x96/#{filetype}.png")

			end
		end
	end

	
	#Checks if the filetype and sha lists exist. If not,
	#they make_methods are called.
	def make_lists()
		if !does_attr_value_exist?('title', 'filetypes')
			make_file_list()
		end

		if !does_attr_value_exist?('title', 'all_shas')
			make_sha_list()
		end
	end

	#Creates the filetype list.
	def make_file_list()

		res = `camput permanode -title="filetypes"`
		sha = res.split("\n")[0]

		set_attributes(sha, 'audio', 'mp3')
		set_attributes(sha, 'audio', 'wav')
		set_attributes(sha, 'document', 'doc')
		set_attributes(sha, 'document', 'pdf')
		set_attributes(sha, 'document', 'txt')
		set_attributes(sha, 'document', 'psd')
		set_attributes(sha, 'document', 'docx')
		set_attributes(sha, 'document', 'pptx')
		set_attributes(sha, 'image',	'jpg')
		set_attributes(sha, 'image',	'jpeg')
		set_attributes(sha, 'image',	'png')
		set_attributes(sha, 'image',	'gif')
		set_attributes(sha, 'image',	'tif')
		set_attributes(sha, 'image',	'bmp')
		set_attributes(sha, 'package',	'zip')
		set_attributes(sha, 'package',	'rar')
		set_attributes(sha, 'package', 	'7z')
		set_attributes(sha, 'video',	'wmv')
		set_attributes(sha, 'video',	'avi')
		set_attributes(sha, 'video',	'mkv')
		set_attributes(sha, 'video',	'mpg')
		set_attributes(sha, 'video',	'mpeg')
		set_attributes(sha, 'video',	'mp4')
		set_attributes(sha, 'video',	'mov')

	end

	#Creates the sha list.
	def make_sha_list()

		`camput permanode -title="all_shas"`

	end

	#Gets everything that's been uploaded to memostore. If there's a filter then only
	#the correct filetype/extension will be shown. 
	def show_everything(filter)

		filenames = Array.new
		icons = Array.new
		thumbnails = Array.new
		links = Array.new
		keys = Array.new

		
		if filter.nil?
			all = get_permanode_attributes(get_sha_from_attr_value('title', 'all_shas'), 'list')
		elsif filter.include? " "
			array = filter.split(" ")

			all = Array.new

			array.each do |type|

				sha = get_sha_from_attr_value('title', type)
				if sha.nil?
					next
				end

				all.concat get_permanode_attributes(sha, 'list')

			end
		elsif does_attr_value_exist?('title', filter)
			all = get_permanode_attributes(get_sha_from_attr_value('title', filter), 'list')
		else
			return nil
		end

		if all.nil?
			return nil
		end	

		all.each do |sha|
			filename = get_permanode_attributes(sha, 'filename')[0]

			if filename.length > 15
				filename = filename[0..15] + "..."
			end

			filenames << filename

			filetype = get_permanode_attributes(sha, 'filetype')[0]
			icons << "Icons/32x32/32x32_" + filetype + ".png"

			thumbnail = get_permanode_attributes(sha, 'thumbnail')

			if thumbnail.nil? && filetype == 'image'
				thumbnails << get_thumbnail(sha)
			elsif thumbnail.nil? && filetype != 'image'
				thumbnails << "Icons/96x96/96x96_" + filetype + ".png"
			else
				thumbnails << thumbnail[0]	
			end

			links << get_permanode_attributes(sha, 'download')[0]
			
			auth = get_permanode_attributes(sha, 'auth')

			keySet = Array.new

			if auth.nil?
				keySet << ''
			else
				auth.each do |k|
					keySet << k
				end
			end

			keys << keySet
		end

		return filenames, icons, thumbnails, links, keys

	end

	
	#Used to get the last 'n' uploads. This is used for the notification window.
	def get_last_n_uploads(n)

		all = get_permanode_attributes(get_sha_from_attr_value('title', 'all_shas'), 'list')
		if !all.nil?
			last_ten = all.reverse.take(n)
		end


		filenames = Array.new
		icons = Array.new

		if !all.nil?

			last_ten.each do |sha|
				filename = get_permanode_attributes(sha, 'filename')[0]

				if filename.length > 20
					filename = filename[0..20] + "..."
				end

				filenames << filename
				
				filetype = get_permanode_attributes(sha, 'filetype')[0]
				icons << "Icons/32x32/32x32_" + filetype + ".png"
			end

		end

		return filenames, icons

	end

	#Adds permanode to the file_extension list and filetype list.
	#If those lists don't exist yet, they are created first.
	def add_sha_to_extension_list(sha, file_extension)

		list_exists = does_attr_value_exist?("title", file_extension)

		if !list_exists
			temp = `camput permanode -title="#{file_extension}"`
			perm = temp.split("\n")[0]
		else
			perm = @result_to_JSON["blobs"][0]["blob"]
		end

		set_attributes(perm, 'list', sha)

	end


	#Gets all the current filetypes
	def get_filetypes_for_filter()

		filetypes = Array.new

		result = get_permanode_attributes(get_sha_from_attr_value('title', 'filetypes'), '')

		result.keys.each do |type|
			if does_attr_value_exist?('title', type)
				filetypes << type
			end
		end

		filetypes.delete('title')

		filetypes

	end

	#Gets all the current extensions
	def get_extensions_for_filter(filetypes)

		result = Array.new

		filetypes.each do |type|

			temp = get_permanode_attributes(get_sha_from_attr_value('title', 'filetypes'), type)
			iter = temp

			iter.each do |ext|

				if !does_attr_value_exist?('title', ext)
					temp -= [ext]
				end

			end

			result << temp

		end

		result


	end

	#Checks whether the file_extension matches a filetype in the filetypes list.
	#If the file_extension can't be matched to a filetype, the returned value is 'unknown'
	def get_filetype(file_extension)

		filetypes = get_permanode_attributes(get_sha_from_attr_value('title', 'filetypes'), '')

		filetype = "unknown"

		filetypes.each do |type|
			if type[1].include? file_extension
				filetype = type[0]
			end
		end

		filetype

	end

	#Generates a random 6 character string
	def random_string()

		(0...6).map { ('a'..'z').to_a[rand(26)] }.join

	end

	#Gets the attribute value that belongs to the sha / attribute_name.
	#If there is no attr name, every attr gets returned.
	def get_permanode_attributes(sha, attr_name)

		describe = `camtool describe #{sha}`

		describe_to_JSON = JSON(describe)

		meta = describe_to_JSON["meta"].keys[0]

		if attr_name == ''
			describe_to_JSON["meta"][meta]["permanode"]["attr"]
		else
			describe_to_JSON["meta"][meta]["permanode"]["attr"][attr_name]
		end

	end

	#Sets an attribute for a certain permanode. If a sha is not added
	#to the parameters, the current permanode attribute is used.
	def set_attributes(*args)

		if args.size == 2
			`camput attr --add #{permanode} #{args[0]} #{args[1]}`
		else
			`camput attr --add #{args[0]} #{args[1]} #{args[2]}`
		end

	end

	#Removes spaces in a string, and replaces them with _.
	def remove_spaces(string)

		if string.include? ' '
				string = string.tr(' ', '_')
		end

		string

	end

	#Returns contentSha and filename
	def download(*args)

		if !does_attr_value_exist?('download', args[0])
			return nil
		end

		sha1 = @result_to_JSON["blobs"][0]["blob"]

		public_shared = get_permanode_attributes(sha1, 'public')[0]
		private_shared = get_permanode_attributes(sha1, 'private')[0]

		if args[1] == "public"
			if !public_shared == "true"
				return nil
			end
		else
			if !private_shared == "true"
				return nil
			end
		end

		@filecontent = get_permanode_attributes(sha1, "camliContent")[0]
		@filename = get_permanode_attributes(sha1, "filename")[0]

		return @filecontent, @filename

	end

	#Collects thumbnail data and adds it as an attribute to the permanode.
	#Temporary IP is used so that it always points to the correct location
	#when the temp IP is replaced by the correct IP.
	def get_thumbnail(sha)

		cc = get_permanode_attributes(sha, "camliContent")[0]

		cc_description = `camtool describe #{cc}`

		cc_dj = JSON(cc_description)

		temp = cc_dj["meta"].keys[0]

		rack = cc_dj["meta"][temp]["file"]["fileName"]

		ip = "IP_HERE_TEMP_HJK"

		thumbnail_location = "http://" + ip +":3179/ui/thumbnail/" + cc + "/" + rack + "?mw=147&tv=2"

		set_attributes(sha, "thumbnail", thumbnail_location)

		thumbnail_location = "http://" + ip +":3179/ui/thumbnail/" + cc + "/" + rack + "?mw=147&tv=2"

	end

	#Gets the sha which has a match for the attr / value. Currently only
	#returns most recent permanode´s sha.
	def get_sha_from_attr_value(attribute, value)

		if !does_attr_value_exist?(attribute, value)
			return nil
		end

		@result_to_JSON["blobs"][0]["blob"]

	end

	#Checks if the given key is valid
	def check_auth(sha, auth)	

		valid_auth = get_permanode_attributes(sha, 'auth')

		valid_auth.include? auth

	end

	#Checks if a permanode exist with an attribute/value pair.
	def does_attr_value_exist?(attribute, value)

		search_result = `camtool search "attr:#{attribute}:#{value}"`

		@result_to_JSON = JSON(search_result)

		!@result_to_JSON["blobs"].nil?

	end

end
