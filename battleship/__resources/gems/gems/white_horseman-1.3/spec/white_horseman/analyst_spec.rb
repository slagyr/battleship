require File.dirname(__FILE__) + '/../spec_helper'
require 'white_horseman/analyst'
require 'white_horseman/battlefield'
require 'white_horseman/cell_status'

describe WhiteHorseman::Analyst do
  before(:each) do
    @hit_map = WhiteHorseman::Battlefield.new
    @hit_map.set_all(WhiteHorseman::CellStatus.new)
    @live_ships = WhiteHorseman::Ship.all
    @analyst = WhiteHorseman::Analyst.new(@hit_map, @live_ships)
  end
  
  it "should zero probability if it's already been missed" do
    @hit_map["G5"] = WhiteHorseman::CellStatus.new(false)
    @analyst.hit_probability("G5").should == 0.0
  end
  
  it "should have starting probablity" do
    @analyst.hit_probability("F5").should == 0.17
  end
    
  it "should have a sure hit" do    
    @hit_map["D5"] = WhiteHorseman::CellStatus.new(false)
    @hit_map["E5"] = WhiteHorseman::CellStatus.new(true)
    @hit_map["E6"] = WhiteHorseman::CellStatus.new(false)
    @hit_map["E4"] = WhiteHorseman::CellStatus.new(false)
    @analyst.hit_probability("F5").should be >= 1.0
  end
  
  it "should no chance if nothing will fit there" do
    @hit_map["A2"] = WhiteHorseman::CellStatus.new(false)
    @hit_map["B1"] = WhiteHorseman::CellStatus.new(false)
    @analyst.hit_probability("A1").should == 0.0
  end
  
  it "should have no chance if the only ship that will fit there has already been sunk" do
    @live_ships.delete(WhiteHorseman::Ship.new(:patrolship))
    @hit_map["A2"] = WhiteHorseman::CellStatus.new(false)
    @hit_map["B2"] = WhiteHorseman::CellStatus.new(false)
    @hit_map["C1"] = WhiteHorseman::CellStatus.new(false)
    
    @analyst.hit_probability("A1").should == 0.0
    @analyst.hit_probability("B1").should == 0.0
  end
  
  it "should have a greater probability when there is a hit two cells away" do
    prob = @analyst.hit_probability("G7")
    @hit_map["G5"] = WhiteHorseman::CellStatus.new(true)
    @analyst.hit_probability("G7").should be > prob    
  end
end
