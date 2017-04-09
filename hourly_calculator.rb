require 'json'
require 'pry'

class HourlyCalculator

	def initialize
		sample = IO.read("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/sample.json")
		hash = JSON.parse(sample)

		calculation = calculate_hours(hash)

		File.write('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/hours.json', JSON.pretty_generate(calculation))
	end

	def calculate_hours(hash)
		mapping = {}
		hash["row"].each_with_index do |element, index|
			hour = element["CreationDate"].split("T").last.split(":").first
			if mapping.key?(hour)
				mapping[hour] = mapping[hour] + 1
			else
				mapping[hour] = 1
			end
		end
		mapping
	end

end

hourly_calculator = HourlyCalculator.new