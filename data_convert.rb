require 'nokogiri'
require 'pry'
require 'json'
require 'xmlsimple'

class DataConvert

	def initialize
		t = Time.now

		# doc = File.open("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.xml")
		# aa = doc.to_json
		# puts Time.now - t
		count = 0
		# File.readlines("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.xml").each do |line|
		# 	count = count + 1
		# 	line = nil
		# end

		refactored_hash = []

		File.foreach("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.xml").with_index do |line, line_num|

			# if line.include? "Tags="
			# 	hash_line = XmlSimple.xml_in(line)
			# 	hash_line.delete("Title")
			# 	hash_line.delete("Body")
			# 	refactored_hash << hash_line
			# end

			noko = Nokogiri::XML(line)
			if line.include? "Tags"
				hash = {}
				hash['Id'] = noko.at("row")['Id']
				hash['CreationDate'] = noko.at("row")['CreationDate']
				hash['Tags'] = noko.at("row")['Tags']
				refactored_hash << hash
				hash = nil
			end
			noko = nil

			count = count + 1

			p count

		end

		puts Time.now - t

		p count

		# aa.search('Body').remove
		#   src.remove
		# end

		# puts Time.now - t

		# hash = XmlSimple.xml_in('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/parts/aa.xml')

		# aa = File.open("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Sample.xml")
		# json = Hash.from_xml(aa).to_json
		# hash["row"] = removeAnswers(hash)

		File.write('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.json', JSON.pretty_generate(refactored_hash))

		puts Time.now - t


		# puts Time.now - t

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
