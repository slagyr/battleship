require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/player_profile'

describe "Locker Room Scene" do

  uses_scene :locker_room

  before(:each) do
    @locker_room = scene
  end

  it "should have a player_list" do
    @locker_room.find("player_list").should_not == nil

    @locker_room.player_list.should == @locker_room.find("player_list")
  end

  it "should be able to add players" do
    player1 = Battleship::PlayerProfile.new(:name => "Bill", :score => 50)
    player2 = Battleship::PlayerProfile.new(:name => "Joe", :score => 60)

    @locker_room.players = [player1, player2]

    @locker_room.player_list.find_by_name("player_list_item").length.should == 2
  end

  it "should loaded a profile when clicked" do
    player1 = Battleship::PlayerProfile.new(:name => "Bill", :score => 50)
    player2 = Battleship::PlayerProfile.new(:name => "Joe", :score => 60)

    @locker_room.players = [player1, player2]
    @locker_room.player_list.find_by_name("player_list_item")[0].mouse_clicked(nil)

    @locker_room.profile.profile.should == player1    
  end

end