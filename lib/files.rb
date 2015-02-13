require 'ostruct'
require 'yaml' # ok even if it is required twice
               # but this file depend on it explicitly


# should be required everywhere where fiel names are needed
# not absolute paths currently and it's ok
#
# FIXME run.sh depends on it?

$files = OpenStruct.new YAML.load <<files
  source: source.yml
  dot: generated.dot
  output: graph.png
files

def from; $files  end
def to;   $files  end
def path; $files  end
