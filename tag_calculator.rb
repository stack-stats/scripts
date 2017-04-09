require 'json'
require 'pry'

class TagCalculator

	def initialize
		sample = IO.read("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.json")
		puts "loaded"
		hash = JSON.parse(sample)
		puts "hashed"


		calculation = calculate_tags(hash)

		File.write('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/tags.json', JSON.pretty_generate(calculation))
	end

	def calculate_tags(hash)
		mapping = {}
		count = 0
		hash.each_with_index do |element, index|
			p count

			if (element["Tags"])
				year = element["CreationDate"].split("-").first
				tags = element["Tags"].tr("<>"," ").split
				if mapping.key?(year)
					tags.each do |tag|
						if mapping[year].key?(tag)
							mapping[year][tag] = mapping[year][tag] + 1
						else
							mapping[year][tag] = 1
						end
					end
				else
					mapping[year] = {}
					tags.each do |tag|
						mapping[year][tag] = 1
					end
				end
			end
			count = count + 1
		end
		mapping
	end

end

tag_calculator = TagCalculator.new