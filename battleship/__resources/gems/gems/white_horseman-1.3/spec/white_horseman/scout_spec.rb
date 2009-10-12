require File.dirname(__FILE__) + '/../spec_helper'
require 'white_horseman/scout'
require 'white_horseman/battlefield'
require "white_horseman/cell_status"

describe WhiteHorseman::Scout do
  before(:each) do
    @scout = WhiteHorseman::Scout.new
    @hit_board = WhiteHorseman::Battlefield.new
    @hit_board.set_all(WhiteHorseman::CellStatus.new)
  end

  it "should calculate possible placements" do
    @scout.possible_placements(2, ["F5"], @hit_board).should == 4
    @scout.possible_placements(3, ["F5"], @hit_board).should == 6
    @scout.possible_placements(4, ["F5"], @hit_board).should == 8
    @scout.possible_placements(5, ["F5"], @hit_board).should == 10
  end

  it "should have no possible placements if coords aren't colinear" do
    @scout.possible_placements(2, ["F5", "G7"], @hit_board).should == 0    
  end

  it "should calculate possible placements for multiple cells" do
    @scout.possible_placements(2, ["F5", "F6"], @hit_board).should == 1
    @scout.possible_placements(3, ["F5", "F6"], @hit_board).should == 2
    @scout.possible_placements(4, ["F5", "F6"], @hit_board).should == 3
    @scout.possible_placements(5, ["F6", "F7"], @hit_board).should == 4

    @scout.possible_placements(2, ["F5", "G5"], @hit_board).should == 1
    @scout.possible_placements(3, ["F5", "G5"], @hit_board).should == 2
    @scout.possible_placements(4, ["F5", "G5"], @hit_board).should == 3
    @scout.possible_placements(5, ["F5", "G5"], @hit_board).should == 4
  end
  
  it "should calculate possible placements for cells with gaps" do
    @scout.possible_placements(2, ["F5", "F7"], @hit_board).should == 0
    @scout.possible_placements(3, ["F5", "F7"], @hit_board).should == 1
    @scout.possible_placements(4, ["F5", "F7"], @hit_board).should == 2
    @scout.possible_placements(5, ["F5", "H5"], @hit_board).should == 3
  end
  
  it "should exclude placements containing misses from possible placements" do
      @hit_board["F6"] = WhiteHorseman::CellStatus.new(false)
      @scout.possible_placements(2, ["F5"], @hit_board).should == 3
  end
  
  it "should excule placements that would leave the battlefield" do
    @scout.possible_placements(5, ["A1"], @hit_board).should == 2
    @scout.possible_placements(5, ["J10"], @hit_board).should == 2
  end
  
  it "should be boxed in" do
    @hit_board["G4"] = WhiteHorseman::CellStatus.new(false)
    @hit_board["F5"] = WhiteHorseman::CellStatus.new(false)
    @hit_board["G6"] = WhiteHorseman::CellStatus.new(false)
    @scout.possible_placements(2, ["G5"], @hit_board).should == 1    
  end
  
  it "should have possible placements for sunken ships" do
    @hit_board["G4"] = WhiteHorseman::CellStatus.new(true)
    @hit_board["G5"] = WhiteHorseman::CellStatus.new(true)
    @hit_board["G6"] = WhiteHorseman::CellStatus.new(true)
    @hit_board["G7"] = WhiteHorseman::CellStatus.new(true)
    

    placements = @scout.salvage_placements(4, "G5", @hit_board)
    placements.size.should == 1
    placements[0].should include("G4")
    placements[0].should include("G5")
    placements[0].should include("G6")
    placements[0].should include("G7")
  end
  
  it "should exclude placements containing hits from sunken ships" do
    @hit_board["E6"] = WhiteHorseman::CellStatus.new(true)    
    @hit_board["E6"].ship = :patrolship
    @hit_board["F6"] = WhiteHorseman::CellStatus.new(true)    
    @hit_board["F6"].ship = :patrolship
    
    @scout.possible_placements(2, ["F5"], @hit_board).should == 3
  end
  

end
