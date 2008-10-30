

module Battleship
  module Analyzers

    class FlogAnalyzer

      ScoreRegex = /: \((\d+\.\d)\)/
      PassingScore = 10.0

      def self.analyze(profile)
        results = `flog -a #{profile.lib_dir}`

        return 0, "Flog not installed properly." if results[0..9] != "Total Flog"

        methods = 0
        passes = 0
        lines = results.split(/$/)
        lines.each do |line|
          match = ScoreRegex.match(line)
          if match
            methods += 1
            score = match[1].to_f
            passes += 1 if score < PassingScore
          end
        end

        score = ((passes.to_f / methods.to_f) * 100.0 + 0.5).to_i
        return score, "#{score} : #{passes}/#{methods} methods pass"
      end

    end

  end
end