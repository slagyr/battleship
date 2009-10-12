require 'white_horseman/battlefield'
require 'yaml'

module WhiteHorseman
  class Opponent
    attr_reader :name
    
    class << self
      def clear_all      
        Dir.glob("#{self.data_path}/*").each do |filename|
          File.delete filename
        end
      end      
    end
  
  
    def initialize(name)
      @name = name
      if File.exists?(filename)
        @games = YAML.load_file(filename)
      else
        @games = []
      end
    end
    
    def new_game
      @games << Battlefield.new      
      return @games.size
    end
    
    def record_target(coordinates)
      @games.last.record_target(coordinates)
    end
    
    def number_of_games
      return @games.size
    end
        
    def game_grid(id)
      @games[id - 1].grid
    end
    
    def save
      Dir.mkdir(self.class.data_path) unless File.exists?(self.class.data_path)
      data_file = File.new(filename, "w")
      data_file.write @games.to_yaml
      data_file.close
    end
    
    def heat_map
      if @games.empty?
        return Battlefield.new
      else
        return Battlefield.average(@games)
      end
    end
    
    
    private
    
    def self.data_path
      return DATA_DIR
    end
    
    def filename
      "#{self.class.data_path}/#{@name}.data"
    end
        
  end
end
