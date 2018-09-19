# Author: Ariel
# Created: 6/11
# Edit: Gail 6/12 Add description
# Description: Generates a json file with pretty printed data

require 'json'
module Jsonify
  # Pretty print the hashed data to json
  def pretty_print(hash_data)
      puts JSON.pretty_generate(hash_data)
  end

  # Generate a json file by given hash_data
  def generate_json_file(hash_data, filename, path='./public')
    FileUtils.mkdir_p(path) unless File.exist?(path)
    File.open(File.join(path, filename),"w") do |f|
      f.write(JSON.pretty_generate(hash_data))
    end
  end

end
