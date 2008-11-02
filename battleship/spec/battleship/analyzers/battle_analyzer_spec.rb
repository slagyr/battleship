require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require 'battleship/analyzers/battle_analyzer'
require 'battleship/player_profile'

describe Battleship::Analyzers::BattleAnalyzer do

  before(:all) do
    self.producer #load the production
  end

  it "should test battle of the Random Player" do
    profile = Battleship::PlayerProfile.load_profile('random_player')
    Battleship::Server.should_receive(:profile).with("Rear Admiral Randy").and_return(Battleship::PlayerProfile.new(:games_played => 100, :wins => 50))

    score, description = Battleship::Analyzers::BattleAnalyzer.analyze(profile)

    score.should == 50
    description.should == "50 : won 50 of 100 games played"
  end

  it "should return 50 is server error" do
    profile = Battleship::PlayerProfile.load_profile('random_player')
    Battleship::Server.should_receive(:profile).with("Rear Admiral Randy").and_raise(Battleship::ServerException.new("server down"))

    score, description = Battleship::Analyzers::BattleAnalyzer.analyze(profile)

    score.should == 50
    description.should == "50 : Couldn't retreive record"
  end

end