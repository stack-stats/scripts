require 'json'
require 'pry'

class AnsweredUnanswered

  @@languages = ["ruby", "javascript", "c#", "c", "c++", "python", "java", "scala", "php", "objective-c", "swift", "r", "perl", "go", "haskell", "elixir", "erlang", "rust"]

  def initialize
    sample = IO.read("/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/Posts.json")
    puts "loaded"
    hash = JSON.parse(sample)
    puts "hashed"

    calculation = calculate_tags(hash)

    File.write('/media/dilum/96648732-125e-4b47-aa00-74d25da99130/Data/answered_unanswered.json', JSON.pretty_generate(calculation))
  end

  def calculate_tags(hash)
    mapping = {}
    sortedmapping = {}
    count = 0
    hash.each_with_index do |element, index|
      p count

      if (element["Tags"])
        all_tags = element["Tags"].tr("<>"," ").split
        tags = all_tags & @@languages
        tags.each do |tag|
          if mapping.key?(tag)
            if element["AcceptedAnswerId"].nil?
              mapping[tag]['unanswered'] = (mapping[tag]['unanswered'] || 0) + 1
            else
              mapping[tag]['answered'] = (mapping[tag]['answered'] || 0) + 1
            end
          else
            mapping[tag] = {}
            if element["AcceptedAnswerId"].nil?
              mapping[tag]['unanswered'] = 1
            else
              mapping[tag]['answered'] = 1
            end
          end
        end
      end
      count = count + 1
    end

    mapping.each do |element, values|
      sorted_values = values.sort_by {|_key, value| _key}.to_h
      sortedmapping[element] = sorted_values
    end
    sortedmapping
  end

end

answered_unanswered = AnsweredUnanswered.new