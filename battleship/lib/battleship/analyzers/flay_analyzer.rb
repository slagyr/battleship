

module Battleship
  module Analyzers

    class FlayAnalyzer

      FAULT_REGEXP = /\(mass = (\d+)\)/

      def self.analyze(profile)
        command = "/usr/bin/find '#{profile.lib_dir}' -name *.rb | /usr/bin/xargs flay" 
        results = `#{command}`

        total_fault = 0
        total_adjusted_fault = 0
        while match = results.match(FAULT_REGEXP)
          fault_str = match[1]
          fault = fault_str.to_i
          total_fault += fault
          total_adjusted_fault += fault / 5
          results = match.post_match
        end

        score = 100 - total_adjusted_fault
        score = 0 if score < 0
        return score, "#{score} : #{total_fault} duplication mass"
      end

    end

  end
end