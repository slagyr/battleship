module Battleship
  module Analyzers

    class SimplicityAnalyzer

      def self.analyze(profile)
        files = Dir.glob(File.join(profile.lib_dir, "**", "*.rb"))
        lines = 0
        files.each do |file|
          lines_str = `wc -l #{file}`
          lines += lines_str.to_i
        end

        return 0, "No code found" if lines == 0
        score = ((100.0 / lines.to_f) * 100.0 + 0.5).to_i
        score = 100 if score > 100

        return score, "#{score} : #{lines} LOC"
      end
      
    end

  end
end