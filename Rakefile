require 'rake/rdoctask'
require 'spec/rake/spectask'


desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['battleship/spec/**/*.rb']
  t.rcov = false
end

desc 'Generate RDoc'
rd = Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'tmp'
  rdoc.options << '--title' << 'Battleship' << '--line-numbers' << '--inline-source' << '--main' << 'README'
  rdoc.rdoc_files.include('README', 'battleship/lib/**/*.rb')
end
task :rdoc