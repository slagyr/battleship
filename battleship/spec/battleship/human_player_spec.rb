require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/human_player'
require 'battleship/mock_war_room'

describe Battleship::HumanPlayer do

  before(:each) do
    @my_war_room = Battleship::MockWarRoom.new
    @opponent_war_room = Battleship::MockWarRoom.new

    @player = Battleship::HumanPlayer.new
    @player.my_war_room = @my_war_room
    @player.opponent_war_room = @opponent_war_room
  end

#  it "should place carrier" do
#    carrier_status = @my_war_room.ship_statuses[:carrier]
#    carrier_status.should_receive(:blink)
#    @my_war_room.sectors.should_receive(:get_placement).with(5).and_return("A1 horizontal")
#    carrier_status.should_receive(:stop_blinking)
#
#    placement = @player.carrier_placement
#    placement.should == "A1 horizontal"
#  end
#
##  it "should place carrier" do
##    carrier_status = @my_war_room.ship_statuses[:carrier]
##    carrier_status.should_receive(:blink)
##    @my_war_room.sectors.should_receive(:get_placement).with(5).and_return("A1 horizontal")
##    carrier_status.should_receive(:stop_blinking)
##
##    placement = @player.carrier_placement
##    placement.should == "A1 horizontal"
##  end


end