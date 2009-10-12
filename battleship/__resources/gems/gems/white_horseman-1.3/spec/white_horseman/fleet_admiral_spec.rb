require File.dirname(__FILE__) + '/../spec_helper'
require 'white_horseman/fleet_admiral'
require 'white_horseman/battlefield'

describe WhiteHorseman::FleetAdmiral do
  before(:each) do
    @ship_placement = WhiteHorseman::FleetAdmiral.new
  end
  
  it "should raise error if calculate hasn't been called" do
    lambda{@ship_placement.destroyer}.should raise_error("Call calculate first")
    lambda{@ship_placement.battleship}.should raise_error("Call calculate first")
    lambda{@ship_placement.submarine}.should raise_error("Call calculate first")
    lambda{@ship_placement.carrier}.should raise_error("Call calculate first")
    lambda{@ship_placement.patrolship}.should raise_error("Call calculate first")
  end
  
  it "should place all ships" do
    @ship_placement.heat_map = WhiteHorseman::Battlefield.new([
      #   1   2   3   4   5   6   7   8   9   10
        [100,100,100,100,100,100, 10, 10, 10, 10], # A
        [100,100,100,100,  0,  0,  0,  0,  0,100], # B
        [100,100,100,100,100,100,100,100,100,100], # C
        [100,100,100,100,100,100,100,100,100,100], # D
        [100,100,100,100, 30,100,100,100,100,100], # E
        [ 15,100,100,100, 30,100,100,100,100,100], # F
        [ 15,100,100,100,100,100,100,100,100,100], # G
        [ 15,100,100,100,100,100,100, 20,100,100], # H
        [100,100,100,100,100,100,100, 20,100,100], # I
        [100,100,100,100,100,100,100, 20,100,100], # J
        ])
    
    @ship_placement.calculate
    @ship_placement.carrier.should == "B5 horizontal"
    @ship_placement.carrier.should == "B5 horizontal"
    @ship_placement.battleship.should == "A7 horizontal"
    
    ["F1 vertical", "H8 vertical"].should include(@ship_placement.submarine)
    ["F1 vertical", "H8 vertical"].should include(@ship_placement.destroyer)
    @ship_placement.patrolship.should == "E5 vertical"
  end
  
  it "should randomize placement when there are multiple equal options" do
    map = WhiteHorseman::Battlefield.new
    map.set_all(0.0)
    @ship_placement.heat_map = map
    @ship_placement.calculate
    first_carrier = @ship_placement.carrier
    
    @ship_placement.calculate
    @ship_placement.carrier.should_not == first_carrier
  end
  
end
