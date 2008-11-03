module Battleship
  module Analyzers

    class CoverageAnalyzer

      CoverageRegexp = /(\d+(.\d)?)%/

      def self.analyze(profile)
        results = `cd #{profile.root_path} && rake -f Battleship.Rakefile spec_with_rcov`
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