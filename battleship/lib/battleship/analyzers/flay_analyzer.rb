

module Battleship
  module Analyzers

    class FlayAnalyzer

      FaultRegexp = /\(mass = (\d+)\)/

      def self.analyze(profile)
        results = `find #{profile.lib_dir} -name *.rb | xargs flay`

        total_fault = 0
        total_adjusted_fault = 0
        while match = output.match(FAULT_REGEXP)
          fault_str = match[1]
          fault = fault_str.to_i
          total_fault += fault
          total_adjusted_fault += fault
          output = match.post_match
        end

        score = 100 - total_adjusted_fault
        return score, "#{score} : #{total_fault} duplication mass"
      end

    end

  end
end