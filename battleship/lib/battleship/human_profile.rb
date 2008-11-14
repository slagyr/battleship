require 'battleship/human_player'

module Battleship

  class HumanProfile

    def self.instance
      @instance = new if @instance.nil?
      return @instance
    end

    def name
      return "Human"
    end

    def create_player
      return HumanPlayer.new
    end

  end

end