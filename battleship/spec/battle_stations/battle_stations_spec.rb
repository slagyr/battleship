require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Sectors" do

  uses_scene :battle_stations

  before(:each) do
  end

  after(:each) do
    sleep(5)
  end

  it "should have some actions" do
    scene.find_by_name("main_menu_link").length.should == 1
    scene.find_by_name("battle_again_link").length.should == 1
  end

  it "should hide and show actions" do
    scene.hide_actions

    scene.find("actions").should == nil
    scene.show_actions

    scene.find("actions").should_not == nil
  end

end