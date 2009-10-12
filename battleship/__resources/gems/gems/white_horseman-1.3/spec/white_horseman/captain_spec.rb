require File.dirname(__FILE__) + '/../spec_helper'

require 'white_horseman/captain'
require 'white_horseman/coordinates'
describe WhiteHorseman::Captain do
  before(:each) do
    @analyst = mock("analyst", :hit_probability => 0.17)
    WhiteHorseman::Analyst.stub!(:new).and_return(@analyst)
    @captain = WhiteHorseman::Captain.new
  end

  it "should record a miss" do
    @captain.target_result("A1", false, nil)
    @captain.hit_map["A1"].should be_miss
  end
  
  it "should record a hit" do
    @captain.target_result("C1", true, nil)
    @captain.hit_map["C1"].should be_hit
  end
  
  it "should select a target" do
    target = WhiteHorseman::Coordinates.new(:string =>"I5")
    @analyst.should_receive(:hit_probability).with(target).and_return(1.5)
    @captain.next_target.should == "I5"
  end
  
  it "should choose randomly from target of equal probablity" do
    @captain.next_target.should_not == @captain.next_target
  end
  
  it "should not target areas already targeted" do
    def @analyst.hit_probability(coords)
      coords.to_s.should_not == "A6"
      coords.to_s.should_not == "A8"
      return 0.17
    end
    
    @captain.target_result("A6", true, nil)
    @captain.target_result("A8", false, nil)
    
    @captain.next_target
  end
  
  it "should have live ships" do
    @captain.live_ships.size.should == 5
  end
  
  it "should record sunken ships" do
    @captain.target_result("G5", true, nil)
    @captain.target_result("G6", true, :patrolship)
    @captain.hit_map["G6"].should have_ship
    @captain.hit_map["G5"].should have_ship
    @captain.live_ships.size.should == 4
  end
    
end
