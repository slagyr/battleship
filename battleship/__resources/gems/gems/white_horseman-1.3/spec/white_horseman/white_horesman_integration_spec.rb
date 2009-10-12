require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'white_horseman/white_horseman'
require 'white_horseman/opponent'

describe WhiteHorseman::WhiteHorseman, "integration" do
  it "should work" do
    WhiteHorseman::Opponent.clear_all
    @horseman = WhiteHorseman::WhiteHorseman.new
    @horseman.new_game("testman")
    
    @horseman.battleship_placement.should_not be_nil
    @horseman.carrier_placement.should_not be_nil
    @horseman.submarine_placement.should_not be_nil
    @horseman.patrolship_placement.should_not be_nil
    @horseman.destroyer_placement.should_not be_nil
    
    @horseman.enemy_targeting("A1")
    
    @horseman.game_over(:victory)
  end

end