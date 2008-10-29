module Battleship

  class PlayerProfile

    attr_reader :name, :score, :author, :description

    def initialize(options={})
      options.each_pair do |key, value|
        if self.respond_to?(key.to_sym)
          self.instance_variable_set("@#{key}", value)
        end
      end
    end

    def flog_score
      return 0
    end

    def coverage_score
      return 0
    end

    def simplicity_score
      return 0
    end

    def battle_score
      return 0
    end



  end
  
end