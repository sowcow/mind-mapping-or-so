require 'ostruct'
require 'yaml'


# should be required everywhere where file names are needed
# not absolute paths currently and it's ok

$files = OpenStruct.new YAML.load <<files
  source: source.yml
  dot: generated.dot
  output: graph.png
files

def from; $files  end
def to;   $files  end
def path; $files  end
