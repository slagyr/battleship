require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/game'
require 'battleship/simple_player'
require 'battleship/mock_war_room'

describe Battleship::Game do

  before(:each) do
    @player1 = Battleship::SimplePlayer.new("Player 1")
    @player2 = Battleship::SimplePlayer.new("Player 2")
    @war_room1 = Battleship::MockWarRoom.new                                
    @war_room2 = Battleship::MockWarRoom.new

    @game = Battleship::Game.new(@player1, @war_room1, @player2, @war_room2)
  end

  it "should be created with two players and two war_rooms" do
    @game.player1.should be(@player1)
    @game.player2.should be(@player2)
    @game.war_room1.should be(@war_room1)
    @game.war_room2.should be(@war_room2)
  end

  it "should create a healthy fleet for each player" do
    @game.prepare

    @game.fleet1[:carrier].life.should == 5
    @game.fleet1[:battleship].life.should == 4
    @game.fleet1[:destroyer].life.should == 3
    @game.fleet1[:submarine].life.should == 3
    @game.fleet1[:patrolship].life.should == 2

    @game.fleet2[:carrier].life.should == 5
    @game.fleet2[:battleship].life.should == 4
    @game.fleet2[:destroyer].life.should == 3
    @game.fleet2[:submarine].life.should == 3
    @game.fleet2[:patrolship].life.should == 2
  end

  it "should place all the ships" do
    @game.prepare

    @game.grid1["A1"].ship.should be(@game.fleet1[:carrier])
    @game.grid1["B1"].ship.should be(@game.fleet1[:battleship])
    @game.grid1["C1"].ship.should be(@game.fleet1[:destroyer])
    @game.grid1["D1"].ship.should be(@game.fleet1[:submarine])
    @game.grid1["E1"].ship.should be(@game.fleet1[:patrolship])

    @game.grid2["A1"].ship.should be(@game.fleet2[:carrier])
    @game.grid2["B1"].ship.should be(@game.fleet2[:battleship])
    @game.grid2["C1"].ship.should be(@game.fleet2[:destroyer])
    @game.grid2["D1"].ship.should be(@game.fleet2[:submarine])
    @game.grid2["E1"].ship.should be(@game.fleet2[:patrolship])
  end

  it "should update the war_rooms when placing ships" do
    @game.prepare

    @war_room1.sectors.placements[0].should == {:type => "carrier", :orientation => :horizontal, :x => 0, :y => 0}
    @war_room1.sectors.placements[1].should == {:type => "battleship", :orientation => :horizontal, :x => 0, :y => 1}
    @war_room1.sectors.placements[2].should == {:type => "destroyer", :orientation => :horizontal, :x => 0, :y => 2}
    @war_room1.sectors.placements[3].should == {:type => "submarine", :orientation => :horizontal, :x => 0, :y => 3}
    @war_room1.sectors.placements[4].should == {:type => "patrolship", :orientation => :horizontal, :x => 0, :y => 4}

    @war_room2.sectors.placements[0].should == {:type => "carrier", :orientation => :horizontal, :x => 0, :y => 0}
    @war_room2.sectors.placements[1].should == {:type => "battleship", :orientation => :horizontal, :x => 0, :y => 1}
    @war_room2.sectors.placements[2].should == {:type => "destroyer", :orientation => :horizontal, :x => 0, :y => 2}
    @war_room2.sectors.placements[3].should == {:type => "submarine", :orientation => :horizontal, :x => 0, :y => 3}
    @war_room2.sectors.placements[4].should == {:type => "patrolship", :orientation => :horizontal, :x => 0, :y => 4}
  end

  it "should play a game" do
    @game.prepare
    @game.play

    @game.winner.should be(@player1)
    @game.fleet1[:carrier].sunk?.should == true
    @game.fleet1[:battleship].sunk?.should == true
    @game.fleet1[:destroyer].sunk?.should == true
    @game.fleet1[:submarine].sunk?.should == true
    @game.fleet1[:patrolship].sunk?.should == false

    @game.fleet2[:carrier].sunk?.should == true
    @game.fleet2[:battleship].sunk?.should == true
    @game.fleet2[:destroyer].sunk?.should == true
    @game.fleet2[:submarine].sunk?.should == true
    @game.fleet2[:patrolship].sunk?.should == true
  end

  it "should update the ship status while playing" do
    @game.prepare
    @game.play

    @war_room1.ship_statuses[:carrier].damage.should == 100
    @war_room1.ship_statuses[:battleship].damage.should == 100
    @war_room1.ship_statuses[:destroyer].damage.should == 100
    @war_room1.ship_statuses[:submarine].damage.should == 100
    @war_room1.ship_statuses[:patrolship].damage.should == 50

    @war_room2.ship_statuses[:carrier].damage.should == 100
    @war_room2.ship_statuses[:battleship].damage.should == 100
    @war_room2.ship_statuses[:destroyer].damage.should == 100
    @war_room2.ship_statuses[:submarine].damage.should == 100
    @war_room2.ship_statuses[:patrolship].damage.should == 100
  end

  #Disqualifications
    # ship placements
    # invalid attack
    # repeated attack

  #how do you indicate winner?
end