require File.dirname(__FILE__) + '/../spec_helper'
require 'white_horseman/coordinates'

describe WhiteHorseman::Coordinates do
  it "should have row and column" do
    @coordinates = WhiteHorseman::Coordinates.new(:string => "A1")
    @coordinates.row.should == "A"
    @coordinates.column.should == 1
  end
  
  it "should be A1 by default" do
    WhiteHorseman::Coordinates.new.to_s.should == "A1"
  end
  
  it "should initialize by row and column" do
    @coordinates = WhiteHorseman::Coordinates.new(:row => "A", :column => 1)
    @coordinates.row.should == "A"
    @coordinates.column.should == 1
    @coordinates.to_s.should == "A1"
  end
  
  it "should raise an error on out of bounds" do
    lambda {WhiteHorseman::Coordinates.new(:string => "K9")}.should raise_error("Row out of range: K")
    lambda {WhiteHorseman::Coordinates.new(:string => "a9")}.should_not raise_error
    lambda {WhiteHorseman::Coordinates.new(:string => "A0")}.should raise_error("Column out of range: 0")
    lambda {WhiteHorseman::Coordinates.new(:string => "A11")}.should raise_error("Column out of range: 11")  
  end
  
  it "should have row index" do
    WhiteHorseman::Coordinates.new(:string => "A1").row_index.should == 0
    WhiteHorseman::Coordinates.new(:string => "J1").row_index.should == 9
  end

  it "should have column index" do
    WhiteHorseman::Coordinates.new(:string => "A1").column_index.should == 0
    WhiteHorseman::Coordinates.new(:string => "J10").column_index.should == 9
  end
  
  it "should add a to_coord method to the String class" do
    "A1".to_coord.row.should == "A"
    "B10".to_coord.column.should == 10
  end
  
  it "should have a to_coord method" do
    coord = WhiteHorseman::Coordinates.new(:string => "A1")
    coord.to_coord.should == coord
  end
  
  it "should increment row" do
    coord = "G5".to_coord

    coord.inc_column

    coord.column.should == 6
  end
  
  it "should increment column" do
    coord = "G5".to_coord

    coord.inc_row

    coord.row.should == "H"        
  end
  
  it "should handle values on inc row" do
    coord = "G5".to_coord

    coord.inc_row -2

    coord.row.should == "E"            
  end
  
  it "should handle values on inc column" do
    coord = "G5".to_coord

    coord.inc_column 4

    coord.to_s.should == "G9"
  end
  
  it "should have equality operator" do
    ("G5".to_coord == "G5".to_coord).should == true
    ("G5".to_coord == "A5".to_coord).should == false
    ("G5".to_coord == "G8".to_coord).should == false
    ("G5".to_coord != "A5".to_coord).should == true
    ("G5".to_coord != "G8".to_coord).should == true    
  end
  
  it "should dup" do
    one = "G5".to_coord
    two = one.dup
    two.column.should == 5
    two.row.should == "G"
    one.row = "B"
    two.row.should == "G"
    one.object_id.should_not == two.object_id
  end
  
  it "should be colinear horizontal" do
    WhiteHorseman::Coordinates.should be_colinear(["F5", "F6"], :horizontal)
    WhiteHorseman::Coordinates.should_not be_colinear(["F5", "G5"], :horizontal)
  end
  
  it "should be colinear vertical" do
    WhiteHorseman::Coordinates.should be_colinear(["F5", "G5"], :vertical)
    WhiteHorseman::Coordinates.should_not be_colinear(["F5", "F8"], :vertical)
  end
  
  it "should be just plain colinear" do
    WhiteHorseman::Coordinates.should be_colinear(["F5", "G5"])
    WhiteHorseman::Coordinates.should be_colinear(["F5", "F6"])    
  end
  
  it "should be colinear with just one point" do
    WhiteHorseman::Coordinates.should be_colinear(["F5"], :vertical)
    WhiteHorseman::Coordinates.should be_colinear(["F5"], :horizontal)
  end
  
  it "should do each" do
    num = 0
    WhiteHorseman::Coordinates.each do |coordinate|
      num += 1
    end
    num.should == 100
  end
  
  it "should have neighbors" do
    coord = WhiteHorseman::Coordinates.new(:string => "G5")
    coord.neighbors.should include("F5")
    coord.neighbors.should include("H5")
    coord.neighbors.should include("G4")
    coord.neighbors.should include("G6")
  end
  
  it "should have neighbors on the borders" do
    coord = WhiteHorseman::Coordinates.new(:string => "A1")
    coord.neighbors.size.should == 2
    coord.neighbors.should include("A2")
    coord.neighbors.should include("B1")
  end
  
  it "should have neighbors on the south eastern border" do
    coord = WhiteHorseman::Coordinates.new(:string => "J10")
    coord.neighbors.size.should == 2
    coord.neighbors.should include("J9")
    coord.neighbors.should include("I10")
  end
  
  it "should have neighbors 2 doors down" do
    coord = WhiteHorseman::Coordinates.new(:string => "G5")
    coord.neighbors(2).should include("E5")
    coord.neighbors(2).should include("I5")
    coord.neighbors(2).should include("G3")
    coord.neighbors(2).should include("G7")
  end
  
  it "should have neighbors two doors down on the edge" do
    coord = WhiteHorseman::Coordinates.new(:string => "B2")
    coord.neighbors(2).size.should == 2
    coord.neighbors(2).should include("B4")
    coord.neighbors(2).should include("D2")
  end

  it "should have neighbors two doors down on the bottom right" do
    coord = WhiteHorseman::Coordinates.new(:string => "I9")
    coord.neighbors(2).size.should == 2
    coord.neighbors(2).should include("I7")
    coord.neighbors(2).should include("G9")
  end
  
end
