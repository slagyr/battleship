require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Welcome Screen" do

  uses_scene :welcome

  before(:each) do
  end

  after(:each) do
#    sleep(5)
  end

  it "should have all players listed" do
    player_options_list = scene.find_by_name("player_options")
    player_options_list.each do |player_options|
      player_options.choices.length.should >= 2  
    end
  end

  it "should have players selectable" do
    player_options_list = scene.find_by_name("player_options")
    player_options_list[0].value = "Rear Admiral Randy"
    player_options_list[1].value = "Sergeant Simple"

    scene.player1.name.should == "Rear Admiral Randy"
    scene.player2.name.should == "Sergeant Simple"
  end

end