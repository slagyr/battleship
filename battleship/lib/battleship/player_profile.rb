require 'yaml'
require 'battleship/analyzers/battle_analyzer'
require 'battleship/analyzers/simplicity_analyzer'
require 'battleship/analyzers/flog_analyzer'
require 'battleship/analyzers/coverage_analyzer'

module Battleship

  class PlayerProfile

    ComputerPlayersDir = File.expand_path(File.dirname(__FILE__) + "/../../computer_players")

    class << self

      def load_all
        profiles = []
        Dir.entries(ComputerPlayersDir).each do |entry|
          if entry != "." && entry != ".."
            yaml = IO.read(File.join(ComputerPlayersDir, entry, 'player.yml'))
            options = YAML.load(yaml)
            profile = PlayerProfile.new(options)
            profiles << profile
            profile.lib_dir = File.join(ComputerPlayersDir, entry, 'lib')
            $: << profile.lib_dir
          end
        end
        return profiles
      end

    end


    attr_reader :name, :author, :description
    attr_reader :player_full_class_name, :player_source_file
    attr_reader :flog_score, :flog_description
    attr_reader :simplicity_score, :simplicity_description
    attr_reader :coverage_score, :coverage_description
    attr_reader :battle_score, :battle_description
    attr_accessor :lib_dir

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

    def color_for_score(score)
      return "red" if score.nil?
      if score < 25
        return "red"
      elsif score < 50
        return "orange"
      elsif score < 75
        return "yellow"
      else
        return "green"
      end

    end

    def average_score
      begin
        return (flog_score + coverage_score + simplicity_score + battle_score) / 4
      rescue Exception
        return 0
      end
    end

    def create_player
      load File.join(lib_dir, player_source_file)
      return eval("#{player_full_class_name}.new")
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

      observer.update_average_score(average_score)
    end

  end

end