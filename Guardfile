require_relative 'lib/files'

build = -> { system 'rake build' }

guard :shell do
  watch path.source, &build
  watch 'Rakefile', &build
end
