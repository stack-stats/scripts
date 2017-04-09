require 'json'
require 'pry'

class MonthlyCalculator

	def initialize
		sample = IO.read("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.json")
		hash = JSON.parse(sample)

		calculation = calculate_monthly(hash)

		File.write('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/monthly.json', JSON.pretty_generate(calculation))
	end

	def calculate_monthly(hash)
		mapping = {}
		count = 0
		hash.each_with_index do |element, index|
			
			p count

			year = element["CreationDate"].split("-").first
			month = element["CreationDate"].split("-")[1]
			if mapping.key?(year)
				if mapping[year].key?(month)
					mapping[year][month] = mapping[year][month] + 1
				else
					mapping[year][month] = 1
				end
			else
				mapping[year] = {}
				mapping[year][month] = 1
			end
			count = count + 1
		end
		mapping
	end

end

monthly_calculator = MonthlyCalculator.new