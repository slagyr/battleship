require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Sectors" do

  uses_scene :battle_stations

  before(:each) do
    @sectors = scene.find("war_room1_sectors")
    @sector = @sectors.children[50]
    @listener = mock("listener")
    @sectors.sector_listener = @listener
  end

  after(:each) do
#    sleep(5)
  end

  it "should announce mouse_enetered to sectors" do
    @listener.should_receive(:sector_entered).with(@sector)
    
    @sector.mouse_entered("mouse_event")
  end

  it "should know it's coordinates" do
    @sectors.children[0].coordinates.should == "A1"
    @sectors.children[99].coordinates.should == "J10"
    @sector.coordinates.should == "F1"
  end

  it "should know slope to other sectors" do
    a1 = @sectors.children[0]
    a10 = @sectors.children[9]
    j1 = @sectors.children[90]
    j10 = @sectors.children[99]

    a1.slope_to(a10).should == 0
    a1.slope_to(j1).should == -100
    a1.slope_to(j10).should == -1
    j1.slope_to(a1).should == 100
    j10.slope_to(a1).should == -1
  end

  it "should know it's right" do
    a1 = @sectors.children[0]
    a2 = @sectors.children[1]
    a10 = @sectors.children[9]
    j1 = @sectors.children[90]
    j2 = @sectors.children[91]

    a1.right.should == a2
    j1.right.should == j2
    a10.right.should == nil    
  end


  it "should know it's right" do
    a1 = @sectors.children[0]
    b1 = @sectors.children[10]
    a10 = @sectors.children[9]
    b10 = @sectors.children[19]
    j2 = @sectors.children[91]

    a1.down.should == b1
    a10.down.should == b10
    j2.down.should == nil    
  end


end