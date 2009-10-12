require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'white_horseman/white_horseman'

describe WhiteHorseman::WhiteHorseman do

  before(:each) do
    @mock_opponent = mock("opponent", :heat_map => nil, :new_game => nil, :name => "mr_mad")
    @mock_admiral = mock("fleet admiral", :heat_map= => nil, :calculate => nil)
    @mock_captain = mock("captain")
    WhiteHorseman::Opponent.stub!(:new).and_return(@mock_opponent)
    WhiteHorseman::FleetAdmiral.stub!(:new).and_return(@mock_admiral)
    WhiteHorseman::Captain.stub!(:new).and_return(@mock_captain)

    lambda { @horseman = WhiteHorseman::WhiteHorseman.new }.should_not raise_error
  end

  it "should create opponent" do
    WhiteHorseman::Opponent.should_receive(:new).with("mr_mad").and_return(@mock_opponent)
    
    @horseman.new_game("mr_mad")
  end
  
  it "should not create a new opponent if playing the same person again" do
    WhiteHorseman::Opponent.should_receive(:new).once.with("mr_mad").and_return(@mock_opponent)
    
    @horseman.new_game("mr_mad")
    @horseman.new_game("mr_mad")
  end
  
  it "should create a new opponent if playing a different person" do
    WhiteHorseman::Opponent.should_receive(:new).with("mr_mad").and_return(@mock_opponent)
    WhiteHorseman::Opponent.should_receive(:new).with("new_guy").and_return(@mock_opponent)
    
    @horseman.new_game("mr_mad")
    @horseman.new_game("new_guy")    
  end

  it "should start a new game" do
    @mock_opponent.should_receive(:new_game)
    
    @horseman.new_game("mr_mad")
  end
  
  it "should record target" do
    @horseman.new_game("mr_mad")
    
    @mock_opponent.should_receive(:record_target).with("A1")
    
    @horseman.enemy_targeting("A1")
  end
  
  it "should create an admiral" do
    WhiteHorseman::FleetAdmiral.should_receive(:new).and_return(@mock_admiral)
    @horseman.new_game("mr_mad")
  end
  
  it "should give the opponent's heat map to the admiral" do
    @heat_map = mock("heat map")
    @mock_opponent.should_receive(:heat_map).and_return(@heat_map)
    @mock_admiral.should_receive(:heat_map=).with(@heat_map)
    
    @horseman.new_game("mr_mad")
  end
  
  it "should calculate admiral" do
    @mock_admiral.should_receive(:calculate)
    
    @horseman.new_game("mr_mad")
  end
  
  it "should save opponent when game ends" do
    @opponent.should_receive(:save)
  
    @horseman.game_over(:victory) 
  end
  
  it "should have a plan capitain" do
    WhiteHorseman::Captain.should_receive(:new).and_return(@mock_captain)
    
    @horseman.new_game("mr_mad")
  end
  
  it "should tell the captain about target results" do
    @mock_captain.should_receive(:target_result).with("G4", true, :battleship)
    
    @horseman.new_game("mr_mad")
    @horseman.target_result("G4", true, :battleship)
  end
  
  it "should ask the capitan for the next target" do
    @mock_captain.should_receive(:next_target).and_return("I9")

    @horseman.new_game("mr_mad")
    @horseman.next_target.should == "I9"
    
  end
end