require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/ship'

describe Battleship::Ship do

  it "should construct a carrier" do
    carrier = Battleship::Carrier.new

    carrier.length.should == 5
    carrier.name.should == "carrier"
  end

  it "should construct a battleship" do
    battleship = Battleship::Battleship.new

    battleship.length.should == 4
    battleship.name.should == "battleship"
  end

  it "should construct a destroyer" do
    destroyer = Battleship::Destroyer.new

    destroyer.length.should == 3
    destroyer.name.should == "destroyer"
  end

  it "should construct a submarine" do
    submarine = Battleship::Submarine.new

    submarine.length.should == 3
    submarine.name.should == "submarine"
  end

  it "should construct a patrolship" do
    patrolship = Battleship::Patrolship.new

    patrolship.length.should == 2
    patrolship.name.should == "patrolship"
  end

  it "should know when a destroyer is sunk" do
    ship = Battleship::Destroyer.new

    3.times do
      ship.sunk?.should == false
      ship.hit!
    end

    ship.sunk?.should == true
  end

  it "should know when a carrier is sunk" do
    ship = Battleship::Carrier.new

    5.times do
      ship.sunk?.should == false
      ship.hit!
    end

    ship.sunk?.should == true
  end

  it "should calculate damage for a carrier" do
    ship = Battleship::Carrier.new

    ship.damage.should == 0
    ship.hit!
    ship.damage.should == 20
    ship.hit!
    ship.damage.should == 40
    ship.hit!
    ship.damage.should == 60
    ship.hit!
    ship.damage.should == 80
    ship.hit!
    ship.damage.should == 100
  end

  it "should calculate damage for a battleship" do
    ship = Battleship::Battleship.new

    ship.damage.should == 0
    ship.hit!
    ship.damage.should == 25
    ship.hit!
    ship.damage.should == 50
    ship.hit!
    ship.damage.should == 75
    ship.hit!
    ship.damage.should == 100
  end



end