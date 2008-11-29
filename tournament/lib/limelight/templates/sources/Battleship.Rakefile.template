#
# DO NOT tamper with this file.  It will lead to disqualification.

require 'rake'
require 'spec/rake/spectask'

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('spec_with_rcov') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_opts = ['-t', '--exclude', 'spec,rcov', '--no-html']
end