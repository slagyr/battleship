require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/human_profile'

describe Battleship::HumanProfile do

  before(:all) do
    @profile = Battleship::HumanProfile.instance  
  end

  it "should have a name" do
    @profile.name.should == "Human"
  end

  it "should create a player" do
    @profile.create_player.class.should == Battleship::HumanPlayer
  end

end