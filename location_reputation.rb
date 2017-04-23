require 'json'
require 'pry'

class LocationReputation

  def initialize
    sample = IO.read("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Users.json")
    puts "loaded"
    hash = JSON.parse(sample)
    puts "hashed"


    calculation = calculate_reputation(hash)

    File.write('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/location_reputation.json', JSON.pretty_generate(calculation))
  end

  def calculate_reputation(hash)
    locations = ["Lanka", "Kandy", "Colombo"]
    mapping = {}
    sortedmapping = {}

    count = 0
    hash.each_with_index do |element, index|
      p count

      if (element["Location"])
        if (element["Location"].match(Regexp.union(locations)))
          reputation = element["Reputation"]
          name = element["DisplayName"]
          location = "Sri Lanka"
          if mapping.key?(location)
            mapping[location][name] = reputation.to_i
          else
            mapping[location] = {}
            mapping[location][name] = reputation.to_i
          end
        end
      end
      count = count + 1
    end

    mapping.each do |element, values|
      sorted_values = values.sort_by {|_key, value| -value}
      chunked_values = sorted_values.each_slice(50).to_a
      count = 1
      chunked_values.each_with_index do |element, index|
        name = "#{(count)} to #{count + 49}"
        sortedmapping[name] = element.to_h
        count = count + 50
      end
    end
    sortedmapping
  end

end

location_reputation = LocationReputation.new