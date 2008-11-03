module Battleship
  module Analyzers

    class SimplicityAnalyzer

      def self.analyze(profile)
        lines = count_lines(profile)

        return 0, "No code found" if lines == 0

        score = (score_for_lines(lines) + 0.5).to_i

        return score, "#{score} : #{lines} LOC"
      end

      def self.count_lines(profile)
        files = Dir.glob(File.join(profile.lib_dir, "**", "*.rb"))
        lines = 0
        files.each do |file|
          lines_str = `wc -l #{file}`
          lines += lines_str.to_i
        end
        return lines
      end

      def self.score_for_lines(lines)
        score = 150.0 * (Math.log(2) / Math.log(lines/100.0 + 1.8))
        score = 100 if score > 100
        return score
      end

    end

  end
end