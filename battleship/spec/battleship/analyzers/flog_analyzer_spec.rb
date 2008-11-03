require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require 'battleship/analyzers/flog_analyzer'
require 'battleship/player_profile'

describe Battleship::Analyzers::FlogAnalyzer do

  before(:all) do
    self.producer #load the production
  end

  it "should flog the Random Player" do
    profile = Battleship::PlayerProfile.load_from_gem('rear_admiral_randy')

    score, description = Battleship::Analyzers::FlogAnalyzer.analyze(profile)

    score.should == 81
    description.should == "81 : 22/27 methods pass"
  end

end