require_relative './lib/yaml_to_dot'
require_relative './lib/files'


desc 'build and run editing process'
task :default => [:build, :edit]

desc 'build graph image'
task :build => :graph


task :edit do
  env = {
    'GRAPH_SOURCE' => path.source,
    'GRAPH_OUTPUT' => path.output,
  }
  system env, './run.sh'
end

task :dot do
  yaml = File.read from.source
  dot = yaml_to_dot yaml
  File.write to.dot, dot
end

task :graph => :dot do
  system 'neato -Goverlap=false -Tpng %s -o %s'\
    % [ from.dot, to.output ]
end
