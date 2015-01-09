class Sha < ActiveRecord::Base

	def random_string()

		(0...6).map { ('a'..'z').to_a[rand(26)] }.join

	end

	def get_thumbnail(camliContent)

		cc_description = `camtool describe #{content}`

		cc_dj = JSON(cc_description)

		temp = cc_dj["meta"].keys[0]

		rack = cc_dj["meta"][temp]["file"]["fileName"]

		ip = "IP_HERE_TEMP_HJK"

		thumbnail_location = "http://" + ip +":3179/ui/thumbnail/" + content + "/" + rack + "?mw=500&tv=2"

	end


	def filter_and_search(filter, search, order_by, type)

		if filter.nil? && search.nil?
			result = Sha.all
			result = result.order("lower(#{order_by}) #{type}")
		elsif filter.nil?
			result = Sha.where('filename LIKE ?', "%#{search}%")
			result = result.order("lower(#{order_by}) #{type}")
		elsif search.nil?
			result = filter_by_filetype(filter, order_by, type)
		else
			temp = filter_by_filetype(filter, order_by, type)
			result = search(temp, search)
		end

		#result = result.sort_by &:created_at
		#result.reverse

	end

	def order(relation, order_by, type)

		temp = relation.order("lower(#{order_by}) #{type}")

	end


	def filter_by_filetype(filters, order_by, type)

		result = Array.new

		filters.each do |filter|
			temp = Sha.where('filetype LIKE ?', "%#{filter}%")
			result += temp.order("lower(#{order_by}) #{type}")
		end

		result

	end

	def search(filter_results, value)

		result = Array.new

		filter_results.each do |element|
			if element.filename.downcase.include? value
				result << element
			end
		end

		result

	end

end
