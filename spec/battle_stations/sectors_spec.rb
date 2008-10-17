require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Sectors" do

  before(:each) do
    @scene = producer.open_scene("battle_stations", producer.theater["default"])
    @sectors = @scene.find("war_room1_sectors")
  end

  after(:each) do
#    sleep(5)
  end

  it "should place a ship horizontal carrier at 0, 0" do
    @sectors.place_ship(:carrier, :horizontal, 0, 0)
    
    @sectors.find_by_name("ship").length.should == 1
    ship = @sectors.find_by_name("ship")[0]
    ship.image.should == 'images/carrier.png'
    ship.rotation.should == 0.0
    ship.style.float.should == "on"
    ship.style.x.should == "1"
    ship.style.y.should == "1"
  end

  it "should place a ship vertical carrier at 0, 0" do
    @sectors.place_ship(:carrier, :vertical, 0, 0)

    @sectors.find_by_name("ship").length.should == 1
    ship = @sectors.find_by_name("ship")[0]
    ship.image.should == 'images/carrier.png'
    ship.rotation.should == 270.0
    ship.style.float.should == "on"
    ship.style.x.should == "1"
    ship.style.y.should == "1"  
  end

  it "should place a ship in the middle of the board" do
    @sectors.place_ship(:patrolship, :horizontal, 5, 5)

    @sectors.find_by_name("ship").length.should == 1
    ship = @sectors.find_by_name("ship")[0]
    ship.image.should == 'images/patrolship.png'
    ship.rotation.should == 0.0
    ship.style.float.should == "on"
    ship.style.x.should == "201"
    ship.style.y.should == "201"
  end

  it "should place an entire fleet" do
    @sectors.place_ship(:battleship, :horizontal, 5, 5)
    @sectors.place_ship(:carrier, :vertical, 9, 5)
    @sectors.place_ship(:destroyer, :horizontal, 1, 1)
    @sectors.place_ship(:submarine, :vertical, 1, 2)
    @sectors.place_ship(:patrolship, :vertical, 0, 7)

    ships = @sectors.find_by_name("ship")
    ships.length.should == 5
    ships[0].image.should == 'images/battleship.png'
    ships[1].image.should == 'images/carrier.png'
    ships[2].image.should == 'images/destroyer.png'
    ships[3].image.should == 'images/submarine.png'
    ships[4].image.should == 'images/patrolship.png'
  end

  it "should mark a miss" do
    @sectors.miss(0, 0)
    @sectors.children[0].style.background_color.should == "#ffffffff"

    @sectors.miss(5, 5)
    @sectors.children[55].style.background_color.should == "#ffffffff"
  end

  it "should mark a hit" do
    @sectors.hit(0, 0)
    @sectors.children[0].style.background_color.should == "#ff0000ff"

    @sectors.hit(5, 5)
    @sectors.children[55].style.background_color.should == "#ff0000ff"
  end

end