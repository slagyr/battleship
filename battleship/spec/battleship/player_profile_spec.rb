require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/player_profile'

describe Battleship::PlayerProfile do

  it "should construct from hash" do
    profile = Battleship::PlayerProfile.new(:name => "Bill", :description => "blah", :author => "Author")

    profile.name.should == "Bill"
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

  it "should perform analysis" do
    profile = Battleship::PlayerProfile.new()

    Battleship::Analyzers::BattleAnalyzer.should_receive(:analyze).with(profile)
    Battleship::Analyzers::SimplicityAnalyzer.should_receive(:analyze).with(profile)
    Battleship::Analyzers::FlogAnalyzer.should_receive(:analyze).with(profile)
    Battleship::Analyzers::CoverageAnalyzer.should_receive(:analyze).with(profile)

    profile.perform_analysis(mock("observer", :null_object => true))
  end

  it "should notify the observer while analyzing" do
    profile = Battleship::PlayerProfile.new()
    profile.stub!(:average_score).and_return(25)
    Battleship::Analyzers::BattleAnalyzer.stub!(:analyze).with(profile).and_return([10, "battle"])
    Battleship::Analyzers::SimplicityAnalyzer.stub!(:analyze).with(profile).and_return([20, "simple"])
    Battleship::Analyzers::FlogAnalyzer.stub!(:analyze).with(profile).and_return([30, "flog"])
    Battleship::Analyzers::CoverageAnalyzer.stub!(:analyze).with(profile).and_return([40, "coverage"])

    observer = mock("observer")
    observer.should_receive(:update_battle_score).with(10, "battle")
    observer.should_receive(:update_simplicity_score).with(20, "simple")
    observer.should_receive(:update_flog_score).with(30, "flog")
    observer.should_receive(:update_coverage_score).with(40, "coverage")
    observer.should_receive(:update_average_score).with(25)

    profile.perform_analysis(observer)
  end

  it "should load profiles from gems" do
    profiles = Battleship::PlayerProfile.load_from_gems
    profiles.length.should >= 2

    profiles.find {|p| p.name == "Rear Admiral Randy" }.root_path.should == "/opt/local/lib/ruby/gems/1.8/gems/rear_admiral_randy-1.0"
    profiles.find {|p| p.name == "Sergeant Simple" }.root_path.should == "/opt/local/lib/ruby/gems/1.8/gems/sergeant_simple-1.0"
  end

  it "should instantiate a player" do
    profile = Battleship::PlayerProfile.load_from_gem("rear_admiral_randy")

    player = profile.create_player

    player.class.name.should == "RearAdmiralRandy::RearAdmiralRandy"
  end

end