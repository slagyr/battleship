require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require 'battleship/analyzers/coverage_analyzer'
require 'battleship/player_profile'

describe Battleship::Analyzers::CoverageAnalyzer do

  before(:all) do
    self.producer #load the production
  end

  it "should test coverage the Random Player" do
    profile = Battleship::PlayerProfile.load_from_gem('rear_admiral_randy')

    score, description = Battleship::Analyzers::CoverageAnalyzer.analyze(profile)

    score.should == 92
    description.should == "92 : 92% test coverage"
  end

end