require 'yaml'


def yaml_to_dot yaml
  #yaml = DATA.read.sub /~~~.*/m, ''

  pieces = YAML.load_documents yaml
  data = join_hashes pieces
  
  dot_contents = data.map { |key, values|
    values.map { |value|
      "  #{key.inspect} -> #{value.inspect}"
    }.join "\n"
  
  }.join "\n\n"
  
  dot = "digraph {\n\n%s\n\n}" % dot_contents
end


def join_hashes hashes
  hashes.each_with_object({}) { |hash, result|
    hash.each { |key, data|
      data = [data].flatten # coerce to an array
      data.map! &:strip # with good looking strings

      if result_array = result[key]
        data.each { |entry|
          # only array of strings
          raise entry.inspect unless entry.is_a? String

          result_array << entry
        }
        result_array.uniq!
      else
        result[key] = data
      end
    }
  }
end
