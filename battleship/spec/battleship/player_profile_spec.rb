require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/player_profile'

describe Battleship::PlayerProfile do

  it "should construct from hash" do
    profile = Battleship::PlayerProfile.new(:name => "Bill", :score => 50, :description => "blah", :author => "Author")

    profile.name.should == "Bill"
    profile.score.should == 50
    profile.description.should == "blah"
    profile.author.should == "Author"
  end

  it "should have zero scores to start with" do
    profile = Battleship::PlayerProfile.new()

    profile.flog_score.should == 0
    profile.coverage_score.should == 0
    profile.simplicity_score.should == 0
    profile.battle_score.should == 0
  end

end