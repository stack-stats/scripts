require 'json'
require 'pry'

class LimitedTagCalculator

	@@languages = ["ruby", "javascript", "c#", "c", "c++", "python", "java", "scala", "php", "objective-c", "swift", "r", "perl", "go", "haskell", "elixir", "erlang", "rust"]

	def initialize
		sample = IO.read("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.json")
		puts "loaded"
		hash = JSON.parse(sample)
		puts "hashed"

		calculation = calculate_tags(hash)

		File.write('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/limited_tags.json', JSON.pretty_generate(calculation))
	end

	def calculate_tags(hash)
		mapping = {}
		count = 0
		hash.each_with_index do |element, index|
			p count

			if (element["Tags"])
				year = element["CreationDate"].split("-").first
				all_tags = element["Tags"].tr("<>"," ").split
				tags = all_tags & @@languages
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

tag_calculator = LimitedTagCalculator.new