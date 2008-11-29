#ruby "/opt/local/lib/ruby/gems/1.8/gems/jscruggs-metric_fu-0.8.0/lib/metric_fu/saikuro/saikuro.rb" --warn_cyclo 5 --error_cyclo 7 --output_directory /tmp/metric_fu/saikuro --input_directory "lib" --filter_cyclo 0 --cyclo

module Battleship
  module Analyzers

    class SaikuroAnalyzer

      FAULT_REGEXP = /<td class="(warning|error)">(\d+)<\/td>/

      SaikuroMain = File.expand_path(File.dirname(__FILE__) + "/saikuro.rb")
      SaikuroOptions = "--warn_cyclo 5 --error_cyclo 7 --output_directory /tmp/saikuro --filter_cyclo 0 --cyclo "

      def self.analyze(profile)
        command = "ruby #{SaikuroMain} #{SaikuroOptions} --input_directory #{profile.lib_dir}"
        system command

        output = IO.read("/tmp/saikuro/index_cyclo.html")

        fault_total = 0
        while match = output.match(FAULT_REGEXP)
          fault_str = match[2]
          fault = fault_str.to_i - 4
          fault_total += fault
          output = match.post_match
        end

        score = 100 - fault_total
        score = 0 if score < 0
        return score, "#{score} : #{fault_total} pts excessive complexity"
      end

    end

  end
end