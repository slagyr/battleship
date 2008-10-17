require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Ship Status" do

  before(:all) do
    @producer = Limelight::Producer.new(File.expand_path(File.dirname(__FILE__) + "/../../"))
    @producer.load
  end

  after(:all) do
    @producer.theater.stages.each { |stage| stage.close }
  end

  before(:each) do
    @scene = @producer.open_scene("battle_stations", @producer.theater["default"])
    @carrier_status = @scene.find("war_room1_carrier_status")
  end

  after(:each) do
#    sleep(2)
  end

  it "should mark damage" do
    @carrier_status.should_not == nil
    @carrier_status.damaged(20)

    @carrier_status.style.background_color.should == "#ff0000ff"
    @carrier_status.style.secondary_background_color.should == "#00000000"
    @carrier_status.style.gradient_penetration.should == "40%"
    @carrier_status.style.gradient_angle.should == "0"
    @carrier_status.style.gradient.should == "on"
  end

  it "should have a default damage of 0%" do
    @carrier_status.damage.should == 0

    @carrier_status.style.background_color.should == "#00000000"
    @carrier_status.style.secondary_background_color.should == "#00000000"
    @carrier_status.style.gradient.should == "off"
  end

  it "should mark damage with 50%" do
    @carrier_status.should_not == nil
    @carrier_status.damaged(50)

    @carrier_status.style.background_color.should == "#ff0000ff"
    @carrier_status.style.secondary_background_color.should == "#00000000"
    @carrier_status.style.gradient_penetration.should == "100%"
    @carrier_status.style.gradient_angle.should == "0"
    @carrier_status.style.gradient.should == "on"
  end

  it "should mark damage with 70%" do
    @carrier_status.should_not == nil
    @carrier_status.damaged(70)

    @carrier_status.style.background_color.should == "#00000000"
    @carrier_status.style.secondary_background_color.should == "#ff0000ff"
    @carrier_status.style.gradient_penetration.should == "60%"
    @carrier_status.style.gradient_angle.should == "180"
    @carrier_status.style.gradient.should == "on"
  end

  it "should mark full damage" do
    @carrier_status.damaged(100)

    @carrier_status.style.background_color.should == "#ff0000ff"
    @carrier_status.style.gradient.should == "off"
  end

end