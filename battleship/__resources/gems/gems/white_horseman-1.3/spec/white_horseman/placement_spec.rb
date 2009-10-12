require File.dirname(__FILE__) + '/../spec_helper'
require 'white_horseman/placement'
require 'white_horseman/battlefield'

describe WhiteHorseman::Placement do
  before(:each) do
    @placement = WhiteHorseman::Placement.new(:row => "A", :column => 1, :orientation => :horizontal, :size => 5)
  end
  
  it "should print" do
    @placement.to_s.should == "A1 horizontal"
  end
  
  it "should have readers" do
    @placement.row.should == "A"
    @placement.column.should == 1
    @placement.orientation.should == :horizontal
    @placement.size.should == 5
  end
  
  it "should be valid" do
    WhiteHorseman::Placement.new(:row => "A",:column => 1, :orientation => :vertical, :size => 5).should be_valid
    WhiteHorseman::Placement.new(:row => "A",:column => 7, :orientation => :vertical, :size => 5).should be_valid
    WhiteHorseman::Placement.new(:row => "A",:column => 7, :orientation => :horizontal, :size => 4).should be_valid
    WhiteHorseman::Placement.new(:row => "H",:column => 1, :orientation => :horizontal, :size => 5).should be_valid
  end
  
  it "should be invalid" do
    WhiteHorseman::Placement.new(:row => "G",:column => 1, :orientation => :vertical, :size => 5).should_not be_valid
    WhiteHorseman::Placement.new(:row => "A",:column => 7, :orientation => :horizontal, :size => 5).should_not be_valid
    WhiteHorseman::Placement.new(:row => "H",:column => 1, :orientation => "bleck", :size => 5).should_not be_valid
  end
    
  it "should overlap" do
    @placement = WhiteHorseman::Placement.new(:row => "C", :column => 1, :orientation => :horizontal, :size => 5)
    @placement2 = WhiteHorseman::Placement.new(:row => "A", :column => 3, :orientation => :vertical, :size => 4)
    
    @placement.should be_overlap(@placement2)
    @placement2.should be_overlap(@placement)    
  end
  
  it "should have cells" do
    @placement.cells.should == ["A1", "A2", "A3", "A4", "A5"]
    WhiteHorseman::Placement.new(:row => "A", :column => 3, :orientation => :vertical, :size => 4).cells.should == ["A3", "B3", "C3", "D3"]
  end
  
  it "should not overlap" do
    @placement = WhiteHorseman::Placement.new(:row => "C", :column => 1, :orientation => :horizontal, :size => 5)
    @placement2 = WhiteHorseman::Placement.new(:row => "D", :column => 3, :orientation => :vertical, :size => 4)
    
    @placement.should_not be_overlap(@placement2)
    @placement2.should_not be_overlap(@placement)        
  end
  
  it "should initialize with coordinates" do
    coord = WhiteHorseman::Coordinates.new(:row => "G", :column => 6)
    @placement = WhiteHorseman::Placement.new(:coord => coord, :orientation => :horizontal, :size => 5)
    @placement.row.should == "G"
    @placement.column.should == 6
    @placement.coord.should == coord
  end
  
  it "should include coordinates" do
    @placement.should include("A1")
    @placement.should include("A2".to_coord)
    @placement.should include("A5".to_coord)
    @placement.should_not include("B1")
    @placement.should_not include("A7".to_coord)
  end
  
  it "should not increment beyond bounds on horizontal include" do
    @placement = WhiteHorseman::Placement.new(:row => "A", :column => 6 , :orientation => :horizontal, :size => 5)
    @placement.should be_valid
    @placement.should include("A6")
    @placement.should include("A7")
    @placement.should include("A8")
    @placement.should include("A9")
    @placement.should include("A10")
    lambda{@placement.should include("A11")}.should raise_error
  end

  it "should not increment beyond bounds on vertical include" do
    place = WhiteHorseman::Placement.new(:row => "F", :column => 6 , :orientation => :vertical, :size => 5)
    place.should be_valid

    place.should include("F6")
    place.row.should == "F"

    place.should include("G6")
    place.should include("H6")
    place.should include("I6")
    place.should include("J6")
    lambda{@placement.should include("K6")}.should raise_error
  end
  
  it "should keep its own copy of coordinate" do
    coordinates = WhiteHorseman::Coordinates.new(:row => "A", :column => 3)
    place = WhiteHorseman::Placement.new(:coord => coordinates , :orientation => :vertical, :size => 5)
    coordinates.row = "C"
    place.row.should == "A"    
  end
  
  it "should do each placement" do
    num = 0
    WhiteHorseman::Placement.each(5) do |placement|
      placement.should be_valid
      num += 1
    end
    num.should == 120
  end
end
