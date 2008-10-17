require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "War Room" do

  before(:each) do
    @scene = producer.open_scene("battle_stations", producer.theater["default"])
    @war_room = @scene.find("war_room1")
  end

  after(:each) do
    #    sleep(2)
  end

  it "should have a commmander's name" do
    @war_room.commander = "Admiral Kirk"

    @scene.find("war_room1_commander").text.should == "Admiral Kirk"
  end

  it "should provide the ship statuses" do
    statuses = @war_room.ship_statuses

    statuses[:carrier].should == @scene.find("war_room1_carrier_status")
    statuses[:battleship].should == @scene.find("war_room1_battleship_status")
    statuses[:destroyer].should == @scene.find("war_room1_destroyer_status")
    statuses[:submarine].should == @scene.find("war_room1_submarine_status")
    statuses[:patrolship].should == @scene.find("war_room1_patrolship_status")
  end

  it "should provide the sectors" do
    sectors = @war_room.sectors

    sectors.should == @scene.find("war_room1_sectors")
  end

  it "should reset" do
    @war_room.ship_statuses.values.each { |status| status.damaged(50) }
    @war_room.sectors.place_ship(:carrier, :horizontal, 5, 5)
    5.times { |i| @war_room.sectors.miss(0, i) }
    5.times { |i| @war_room.sectors.hit(1, i) }

    @war_room.reset

    @war_room.ship_statuses.values.each { |status| status.damage.should == 0 }
    @war_room.sectors.children.length.should == 100
    @war_room.sectors.children.each { |sector| sector.style.background_color.should == "#00000000" }
  end

end