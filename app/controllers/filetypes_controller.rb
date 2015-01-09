class FiletypesController < ApplicationController

	def new
		@filetype = Filetype.new
	end

	def create

	end


	private

		def filetype_params
			params.require(:filetype).permit(:extension, :filetype)
		end

end
