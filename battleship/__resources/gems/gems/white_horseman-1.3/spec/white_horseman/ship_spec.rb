require File.dirname(__FILE__) + '/../spec_helper'
require 'white_horseman/ship'

describe WhiteHorseman::Ship do
  it "should have symbol and size" do
    ship = WhiteHorseman::Ship.new(:battleship)
    ship.symbol.should == :battleship
    ship.size.should == 4
  end
  
  it "should have the correct size for all ships" do
    ship = WhiteHorseman::Ship.new(:patrolship).size.should == 2
    ship = WhiteHorseman::Ship.new(:carrier).size.should == 5
    ship = WhiteHorseman::Ship.new(:submarine).size.should == 3
    ship = WhiteHorseman::Ship.new(:destroyer).size.should == 3
  end
  
  it "should have each ship" do
    ships = []
    WhiteHorseman::Ship.each do |ship|
      ships << ship
    end
    check_ships(ships)
  end
  
  it "should have all the ships" do
    ships = WhiteHorseman::Ship.all
    ships.size.should == 5
    check_ships(ships)
  end
  
  def check_ships(ships)
    ships.size.should == 5
    ships[0].symbol.should == :carrier
    ships[1].symbol.should == :battleship
    ships[2].symbol.should == :destroyer
    ships[3].symbol.should == :submarine
    ships[4].symbol.should == :patrolship
  end
  
  it "should have equality operator" do
    WhiteHorseman::Ship.new(:battleship).should == WhiteHorseman::Ship.new(:battleship)
  end
end
