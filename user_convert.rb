require 'nokogiri'
require 'pry'
require 'json'
require 'xmlsimple'

class DataConvert

  def initialize
    t = Time.now
    count = 0


    refactored_hash = []

    File.foreach("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Users.xml").with_index do |line, line_num|

      noko = Nokogiri::XML(line)
      if line.include? "Location"
        hash = {}
        hash['Id'] = noko.at("row")['Id']
        hash['Location'] = noko.at("row")['Location']
        hash['Reputation'] = noko.at("row")['Reputation']
        hash['Age'] = noko.at("row")['Age']
        hash['DisplayName'] = noko.at("row")['DisplayName']
        refactored_hash << hash
        hash = nil
      end
      noko = nil

      count = count + 1

      p count

    end

    puts Time.now - t

    p count

    File.write('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Users.json', JSON.pretty_generate(refactored_hash))

    puts Time.now - t


  end

end

data = DataConvert.new
