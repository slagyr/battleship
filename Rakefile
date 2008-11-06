require 'rake/rdoctask'
require 'spec/rake/spectask'


desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['battleship/spec/**/*.rb']
  t.rcov = false
end

desc 'Generate RDoc'
rd = Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'website/battleship'
  rdoc.options << '--title' << 'Battleship' << '--line-numbers' << '--inline-source' << '--main' << 'README'
  rdoc.rdoc_files.include('README', '**/simple_player.rb')
end
task :rdoc

task :verify_user do
  raise "RUBYFORGE_USER environment variable not set!" unless ENV['RUBYFORGE_USER']
end

task :verify_password do
  raise "RUBYFORGE_PASSWORD environment variable not set!" unless ENV['RUBYFORGE_PASSWORD']
end

desc "Upload Website to RubyForge"
task :publish_rubyforge_site => [:verify_user, :verify_password] do
  require 'rake/contrib/rubyforgepublisher'
  publisher = Rake::SshDirPublisher.new(
    "#{ENV['RUBYFORGE_USER']}@rubyforge.org",
    "/var/www/gforge-projects/sparring/",
    "website"
  )

  publisher.upload
end

desc "Build the battleship.llp file and install in website dir"
task :llp do
  system "rm battleship.llp"
  system "jruby -S limelight pack battleship"
  system "mv battleship.llp website/battleship/"
end