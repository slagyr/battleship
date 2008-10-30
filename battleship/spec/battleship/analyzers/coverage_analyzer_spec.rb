require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require 'battleship/analyzers/coverage_analyzer'
require 'battleship/player_profile'

describe Battleship::Analyzers::CoverageAnalyzer do

  before(:all) do
    self.producer #load the production
  end

  it "should test coverage the Random Player" do
    profile = Battleship::PlayerProfile.load_profile('random_player')

    score, description = Battleship::Analyzers::CoverageAnalyzer.analyze(profile)

    score.should == 80
    description.should == "80 : 80% test coverage"
  end

end