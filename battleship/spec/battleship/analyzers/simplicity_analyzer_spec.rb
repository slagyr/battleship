require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require 'battleship/analyzers/simplicity_analyzer'
require 'battleship/player_profile'

describe Battleship::Analyzers::SimplicityAnalyzer do

  before(:all) do
    self.producer #load the production
  end

  it "should check simplicity of the Random Player" do
    profile = Battleship::PlayerProfile.load_from_gem('rear_admiral_randy')

    score, description = Battleship::Analyzers::SimplicityAnalyzer.analyze(profile)

    score.should == 80
    description.should == "80 : 187 LOC"
  end

  it "should be logarithmic" do
    Battleship::Analyzers::SimplicityAnalyzer.score_for_lines(100).to_i.should == 100
    Battleship::Analyzers::SimplicityAnalyzer.score_for_lines(120).to_i.should == 94
    Battleship::Analyzers::SimplicityAnalyzer.score_for_lines(200).to_i.should == 77
    Battleship::Analyzers::SimplicityAnalyzer.score_for_lines(400).to_i.should == 59
    Battleship::Analyzers::SimplicityAnalyzer.score_for_lines(800).to_i.should == 45
    Battleship::Analyzers::SimplicityAnalyzer.score_for_lines(1600).to_i.should == 36
  end

end