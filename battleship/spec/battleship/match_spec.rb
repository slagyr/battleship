require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/match'
require 'battleship/player_profile'
require 'battleship/mock_battle_stations'
require 'battleship/simple_player'

describe Battleship::Match do

  before do
    Battleship::Server.stub!(:submit_game)
    @bill = Battleship::PlayerProfile.new(:name => "Bill", :description => "blah", :author => "Author", :filename => "bill")
    @bill.stub!(:create_player).and_return(Battleship::SimplePlayer.new)
    @fred = Battleship::PlayerProfile.new(:name => "Fred", :description => "blah", :author => "Author", :filename => "fred")
    @fred.stub!(:create_player).and_return(Battleship::SimplePlayer.new)
    @ui = Battleship::MockBattleStations.new

    @match = Battleship::Match.new(1, @bill, @fred, @ui)
  end

  it "should get constructed" do
    match = Battleship::Match.new(11, @bill, @fred, @ui)

    match.wins_required.should == 11
    match.player1.should == @bill
    match.player2.should == @fred
    match.ui.should == @ui
  end

  it "should play match of 1 game" do
    @match.begin

    @ui.was_reset.should == true
    @ui.stats.should == "1 : 0"
    @match.winner.should == @bill
  end

  it "should record games" do
    @match.begin

    @match.games.length.should == 1
  end

  it "should have a directory name" do
    @match.dir_name.should == "bill_VS_fred"
  end

end
