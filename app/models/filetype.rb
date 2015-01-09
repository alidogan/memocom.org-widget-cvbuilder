class Filetype < ActiveRecord::Base

	def get_filetype(extension)

		result = Filetype.find_by(extension: extension)

		if !result.nil?
			result.filetype
		else
			"unknown"
		end

	end

end
