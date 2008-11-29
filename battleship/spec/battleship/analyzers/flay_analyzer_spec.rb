require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require 'battleship/analyzers/flay_analyzer'
require 'battleship/player_profile'

describe Battleship::Analyzers::FlayAnalyzer do

  before(:all) do
    self.producer #load the production
  end

  it "should flay the Random Player" do
    profile = Battleship::PlayerProfile.load_from_gem('micahs_fury')

    score, description = Battleship::Analyzers::FlayAnalyzer.analyze(profile)

    score.should == 100
    description.should == "100 : 0 duplication mass"
  end

end