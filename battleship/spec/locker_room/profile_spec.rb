require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/player_profile'

describe "Player Profile Prop" do

  uses_scene :locker_room

  before(:each) do
    @profile = scene.find("profile")
  end

  it "should load the player info" do
    player = Battleship::PlayerProfile.new(:name => "Bill", :score => 50, :author => "Ted", :description => "Excellent")

    @profile.profile = player

    scene.find('player_name').text.should == "Bill"
    scene.find('author_name').text.should == "Ted"
    scene.find('description').text.should == "Excellent"
  end
  
  it "should load the player scores" do
    player = Battleship::PlayerProfile.new(:name => "Bill", :score => 50, :author => "Ted", :description => "Excellent")
    player.stub!(:battle_score).and_return(10)
    player.stub!(:simplicity_score).and_return(30)
    player.stub!(:coverage_score).and_return(50)
    player.stub!(:flog_score).and_return(75)

    @profile.profile = player

    sleep(5)

    @profile.battle_graph.score.should == 10
    @profile.simplicity_graph.score.should == 30
    @profile.coverage_graph.score.should == 50
    @profile.flog_graph.score.should == 75
  end

end