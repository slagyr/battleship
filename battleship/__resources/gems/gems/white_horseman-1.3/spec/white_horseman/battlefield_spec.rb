require File.dirname(__FILE__) + '/../spec_helper'
require 'white_horseman/battlefield'
describe WhiteHorseman::Battlefield do
  before(:each) do
    @battlefield = WhiteHorseman::Battlefield.new
  end
  it "should have the grid" do
    @battlefield.record_target("A1")
    @battlefield.record_target("B4")
    @battlefield.record_target("F8")
    
    @battlefield.shots.should == 3
    @battlefield.grid.should == [
      [99,0,0,0,0,0,0,0,0,0],
      [0,0,0,98,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,97,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      ]
  end
  
  it "should grids for multiple games" do
    @battlefield.record_target("J10")
    @battlefield.record_target("G4")
    @battlefield.record_target("f1")
    @battlefield.record_target("B9")
    
    @battlefield.shots.should == 4
    @battlefield.grid.should == [
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,96,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [97,0,0,0,0,0,0,0,0,0],
      [0,0,0,98,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,99],
      ]
  end

  it "should build with a grid" do
    @battlefield = WhiteHorseman::Battlefield.new([
     [0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,96,0],
     [0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,0],
     [97,0,0,0,0,0,0,0,0,0],
     [0,0,0,98,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0,0,99],
     ])
     
    @battlefield.grid.should ==  [
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,96,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [97,0,0,0,0,0,0,0,0,0],
      [0,0,0,98,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,99],
      ] 
  end
  
  it "should set cells" do
    @battlefield["A1"] = 124
    @battlefield["A1"].should == 124
  end
  
  it "should set all" do
    @battlefield.set_all(100)
    @battlefield.grid.flatten.all?{ |cell| cell == 100}.should == true
  end
  
  it "should average multiple battlefields" do
    battlefield1 = WhiteHorseman::Battlefield.new([
        [5,0,0,0,0,0,0,0,0,0],
        [0,10,0,0,0,0,0,0,0,0],
        [0,0,15,0,0,0,0,0,0,0],
        [0,20,0,0,0,0,0,0,0,0],
        [25,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        ])
    battlefield2 = WhiteHorseman::Battlefield.new([
        [10,0,0,0,0,0,0,0,0,0],
        [0,10,0,0,0,0,0,0,0,0],
        [0,0,25,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [100,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        ])
    average = WhiteHorseman::Battlefield.average([battlefield1, battlefield2])
    average["A1"].should == 7.5
    average["B2"].should == 10
    average["C3"].should == 20
    average["D2"].should == 10
    average["E1"].should == 62.5

  end
  
  
end