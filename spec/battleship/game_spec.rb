require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/game'

describe Battleship::Game do

  before(:each) do
    @player1 = mock("player1")
    @player2 = mock("player2")

    @game = Battleship::Game.new(@player1, @player2)
  end

  it "should be created with two players" do
    @game.player1.should be(@player1)
    @game.player2.should be(@player2)
  end

  it "should ask each player to place ships" do
    @player1.should_receive(:carrier_position).and_return("A1 horizontal" )
    @player1.should_receive(:battleship_position).and_return("B1 horizontal")
    @player1.should_receive(:destroyer_position).and_return("C1 horizontal")
    @player1.should_receive(:submarine_position).and_return("D1 horizontal")
    @player1.should_receive(:patrolship_position).and_return("E1 horizontal")

    @game.position_ships(@player1)
  end


end