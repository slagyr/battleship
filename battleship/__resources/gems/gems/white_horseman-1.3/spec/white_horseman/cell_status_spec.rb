require File.dirname(__FILE__) + '/../spec_helper'
require 'white_horseman/cell_status'
describe WhiteHorseman::CellStatus do
  before(:each) do
    @cell = WhiteHorseman::CellStatus.new
  end
  it "should hit" do
    @cell.should_not be_hit
    @cell.hit
    @cell.should be_hit
  end
  
  it "should miss" do
    @cell.should_not be_miss
    @cell.miss
    @cell.should be_miss
  end
  
  it "should initailize with hit" do
    WhiteHorseman::CellStatus.new(true).should be_hit
    WhiteHorseman::CellStatus.new(false).should be_miss
  end
  
  it "should have no shot" do
    @cell.should be_empty
    @cell.hit
    @cell.should_not be_empty
  end
  
  it "should have ship" do
    @cell.should_not have_ship
    @cell.ship = :battleship
    @cell.should have_ship
    @cell.ship.should == :battleship
  end
  
end
