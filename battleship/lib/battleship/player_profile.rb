require 'yaml'
require 'battleship/analyzers/battle_analyzer'
require 'battleship/analyzers/simplicity_analyzer'
require 'battleship/analyzers/flog_analyzer'
require 'battleship/analyzers/coverage_analyzer'
require 'battleship/analyzers/saikuro_analyzer'
require 'battleship/analyzers/flay_analyzer'
require 'etc'

module Battleship

  class PlayerProfile

    ComputerPlayersDir = File.expand_path(File.dirname(__FILE__) + "/../../computer_players")

    class << self

      def gem_index
        if @gem_index.nil?
          if File.exists? File.expand_path("~/.gem_home")
            system_gem_path = IO.read(File.expand_path("~/.gem_home")).strip
          elsif File.exists? File.expand_path("~/gem_home.txt")
            system_gem_path = IO.read(File.expand_path("~/gem_home.txt")).strip
          elsif File.exists? File.expand_path("~/.bash_profile")
            system_gem_path = `. ~/.profile && ruby -e "require 'rubygems'; puts Gem.path"`
          elsif File.exists? File.expand_path("~/.profile")
            system_gem_path = `. ~/.profile && ruby -e "require 'rubygems'; puts Gem.path"`
          else
            system_gem_path = `ruby -e "require 'rubygems'; puts Gem.path"`
          end
          ENV['GEM_PATH'] = system_gem_path.strip
          Gem.clear_paths
          @gem_index = Gem.source_index
        end
        return @gem_index
      end

      def load_from_gems
        profiles = []
        gem_index.latest_specs.each do |spec|
          if spec.summary[0..17] == "Battleship Player:"
            profiles << load_from_gem(spec)
          end
        end
        return profiles
      end

      def load_from_gem(name_or_spec)
        spec = name_or_spec.is_a?(String) ? find_gem_spec(name_or_spec) : name_or_spec
        return if spec.nil?
        options = {}
        options[:filename] = spec.name
        options[:classname] = spec.name.camalized
        options[:name] = spec.summary[18..-1]
        options[:author] = spec.author
        options[:description] = spec.description
        options[:root_path] = spec.full_gem_path
        return PlayerProfile.new(options)
      end

      def find_gem_spec(name)
        return gem_index.latest_specs.find { |spec| spec.name == name }
      end

      def player_hash
        if @player_hash.nil?
          @player_hash = {}
          load_from_gems.each { |p| @player_hash[p.name] = p }
        end
        return @player_hash
      end
    end


    attr_reader :name, :author, :description
    attr_reader :filename, :classname, :root_path
    attr_reader :flog_score, :flog_description
    attr_reader :simplicity_score, :simplicity_description
    attr_reader :coverage_score, :coverage_description
    attr_reader :battle_score, :battle_description
    attr_reader :saikuro_score, :saikuro_description
    attr_reader :flay_score, :flay_description
    attr_reader :games_played, :wins, :disqualifications

    def initialize(options={})
      @flog_score = 0
      @simplicity_score = 0
      @coverage_score = 0
      @battle_score = 0
      options.each_pair do |key, value|
        if self.respond_to?(key.to_sym)
          self.instance_variable_set("@#{key}", value)
        end
      end
    end

    def simple_hash
      return {:name => name,
          :author => author,
          :description => description}
    end

    def color_for_score(score)
      return "red" if score.nil?
      if score < 25
        return "red"
      elsif score < 50
        return "orange_red"
      elsif score < 60
        return "orange"
      elsif score < 70
        return "gold"
      elsif score < 80
        return "yellow"
      elsif score < 90
        return "green_yellow"
      else
        return "green"
      end

    end

    def average_score
      begin
        return (flog_score + coverage_score + simplicity_score + battle_score + saikuro_score + flay_score) / 6
      rescue Exception
        return 0
      end
    end

    def create_player
      require "#{filename}/#{filename}"
      return eval("#{classname}::#{classname}.new")
    end

    def perform_analysis(observer)
      @battle_score, @battle_description = Analyzers::BattleAnalyzer.analyze(self)
      observer.update_battle_score(@battle_score, @battle_description)

      @simplicity_score, @simplicity_description = Analyzers::SimplicityAnalyzer.analyze(self)
      observer.update_simplicity_score(@simplicity_score, @simplicity_description)

      @coverage_score, @coverage_description = Analyzers::CoverageAnalyzer.analyze(self)
      observer.update_coverage_score(@coverage_score, @coverage_description)

      @flog_score, @flog_description = Analyzers::FlogAnalyzer.analyze(self)
      observer.update_flog_score(@flog_score, @flog_description)

      @saikuro_score, @saikuro_description = Analyzers::SaikuroAnalyzer.analyze(self)
      observer.update_saikuro_score(@saikuro_score, @saikuro_description)

      @flay_score, @flay_description = Analyzers::FlayAnalyzer.analyze(self)
      observer.update_flay_score(@flay_score, @flay_description)

      observer.update_average_score(average_score)
    end

    def lib_dir
      return File.join(root_path, "lib")
    end

  end

end

class String

  def camalized(starting_case = :upper)
    value = self.downcase.gsub(/[_| ][a-z]/) { |match| match[-1..-1].upcase }
    value = value[0..0].upcase + value[1..-1] if starting_case == :upper
    return value
  end

  def underscored
    value = self[0..0].downcase + self[1..-1]
    value = value.gsub(/[A-Z]/) { |cap| "_#{cap.downcase}" }
    return value
  end

  def titleized(starting_case = :upper)
    value = self.gsub(/[a-z0-9][A-Z]/) { |match| "#{match[0..0]} #{match[-1..-1]}" }
    value = value.gsub(/[_| ][a-z]/) { |match| " #{match[-1..-1].upcase}" }
    return value[0..0].upcase + value[1..-1]
  end
end