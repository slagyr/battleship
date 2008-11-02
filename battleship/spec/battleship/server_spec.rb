require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/server'

describe Battleship::Server do

  it "should register and retrieve profiles" do
    profile = Battleship::PlayerProfile.load_profile('random_player')

    Battleship::Server.register_profile(profile)

    profile = Battleship::Server.profile("Rear Admiral Randy")
    profile.author.should == "Micah Martin"
  end

end