require 'nokogiri'
require 'pry'
require 'json'
require 'xmlsimple'

class DataConvert

	def initialize
		t = Time.now

		refactored_hash = []

		File.foreach("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.xml").with_index do |line, line_num|

			noko = Nokogiri::XML(line)
			if line.include? "Tags"
				hash = {}
				hash['Id'] = noko.at("row")['Id']
				hash['CreationDate'] = noko.at("row")['CreationDate']
				hash['Tags'] = noko.at("row")['Tags']
				hash['AcceptedAnswerId'] = noko.at("row")['AcceptedAnswerId']
				refactored_hash << hash
				hash = nil
			end
			noko = nil

			p line_num

		end

		puts Time.now - t

		File.write('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.json', JSON.pretty_generate(refactored_hash))

		puts Time.now - t

	end

	def removeAnswers(hash)
		refactored_hash = []
		puts hash["row"].size
		hash["row"].each_with_index do |element, index|
			if element.key?("Tags")
				element.delete("Title")
				element.delete("Body")
				refactored_hash << element
			end
		end
		puts refactored_hash.size
		refactored_hash
	end

end

data = DataConvert.new
