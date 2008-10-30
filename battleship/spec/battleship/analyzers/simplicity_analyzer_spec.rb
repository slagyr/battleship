require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require 'battleship/analyzers/simplicity_analyzer'
require 'battleship/player_profile'

describe Battleship::Analyzers::SimplicityAnalyzer do

  before(:all) do
    self.producer #load the production
  end

  it "should check simplicity of the Random Player" do
    profile = Battleship::PlayerProfile.load_profile('random_player')

    score, description = Battleship::Analyzers::SimplicityAnalyzer.analyze(profile)

    score.should == 100
    description.should == "100 : 98 LOC"
  end

end