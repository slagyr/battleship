module Battleship
  module Analyzers

    class CoverageAnalyzer

      RakefileSrc = <<END
require 'rake'
require 'spec/rake/spectask'

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('spec_with_rcov') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_opts = ['-t', '--exclude', 'spec']
end
END

      CoverageRegexp = /(\d+(.\d)?)%/

      def self.analyze(profile)
        player_root = File.dirname(profile.lib_dir)
        File.open(File.join(player_root, "Battleship.Rakefile"), 'w') { |file| file.write RakefileSrc }
        results = `cd #{player_root} && rake -f Battleship.Rakefile spec_with_rcov`
        return 0, "Failures!" if !results.include?("0 failures")
        lines = results.split(/^/)
        last = lines[-1]
        match = CoverageRegexp.match(last)
        return 0, "Errors checking coverage." if match.nil?

        score = (match[1].to_f + 0.5).to_i
        return score, "#{score} : #{score}% test coverage"
      end

    end

  end
end