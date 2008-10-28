require 'rake/rdoctask'

desc 'Generate RDoc'
rd = Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'tmp'
  rdoc.options << '--title' << 'Battleship' << '--line-numbers' << '--inline-source' << '--main' << 'README'
  rdoc.rdoc_files.include('README', 'battleship/lib/**/*.rb')
end
task :rdoc