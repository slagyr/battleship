require File.dirname(__FILE__) + '/../spec_helper'

require 'white_horseman/opponent'
describe WhiteHorseman::Opponent do

  before(:each) do
    WhiteHorseman::Opponent.clear_all
    @opponent = WhiteHorseman::Opponent.new("dr_evil")
  end

  it "should have name" do
    @opponent.name.should == "dr_evil"
  end
  
  it "should create a new game" do
    id = @opponent.new_game
    id.should == 1
    @opponent.number_of_games.should == 1
  end
  
  it "should create multiple games" do
    @opponent.new_game.should_not == @opponent.new_game
    @opponent.number_of_games.should == 2
  end
  
  it "should grids for multiple games" do
    mockfield = mock("Battlefield")
    WhiteHorseman::Battlefield.should_receive(:new).and_return(mockfield)
    mockfield.should_receive(:record_target).with("J10")
    id = @opponent.new_game
    @opponent.record_target("J10")    
  end
  
  it "should save the game" do
    @opponent.new_game
    @opponent.save
    
    loaded = WhiteHorseman::Opponent.new("dr_evil")
    loaded.number_of_games.should == 1    
  end
  
  it "should have heat map" do
    mockfield1 = mock("Battlefield1")
    mockfield2 = mock("Battlefield2")
    mockfield3 = mock("Battlefield3")
    WhiteHorseman::Battlefield.should_receive(:new).exactly(3).and_return(mockfield1, mockfield2, mockfield3)
    3.times {@opponent.new_game}
    average_field = mock("Battlefield ave")
    WhiteHorseman::Battlefield.should_receive(:average).with([mockfield1, mockfield2, mockfield3]).and_return(average_field)

    @opponent.heat_map.should == average_field
  end
  
  it "should zeroed heat map when there are no games" do
    @opponent.heat_map["A1"].should == 0
  end
      
end