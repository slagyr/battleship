require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require 'limelight/templates/player_templater'

describe Limelight::Templates::PlayerTemplater do

  it "should know names" do
    templater = Limelight::Templates::PlayerTemplater.new("Simple Bot")

    templater.filename.should == "simple_bot"
    templater.tokens[:CLASSNAME].should == "SimpleBot"
    templater.tokens[:PLAYER_NAME].should == "Simple Bot"
  end

  it "should know names with a little punctuation" do
    templater = Limelight::Templates::PlayerTemplater.new("Satan's Revenge!")

    templater.filename.should == "satans_revenge"
    templater.tokens[:CLASSNAME].should == "SatansRevenge"
    templater.tokens[:PLAYER_NAME].should == "Satan's Revenge!"
  end

  it "should know names with a lot of punctuation" do
    templater = Limelight::Templates::PlayerTemplater.new("Bl'ah? *Bl-!ah.;")

    templater.filename.should == "blah_blah"
    templater.tokens[:CLASSNAME].should == "BlahBlah"
    templater.tokens[:PLAYER_NAME].should == "Bl'ah? *Bl-!ah.;"
  end

  it "should generate files" do
    templater = Limelight::Templates::PlayerTemplater.new("Simple Bot")

    templater.should_receive(:file).with("simple_bot/Rakefile", "Rakefile.template", anything)
    templater.should_receive(:file).with("simple_bot/Battleship.Rakefile", "Battleship.Rakefile.template", anything)
    templater.should_receive(:file).with("simple_bot/lib/simple_bot/simple_bot.rb", "player.template", anything)
    templater.should_receive(:file).with("simple_bot/spec/spec_helper.rb", "spec_helper.template", anything)
    templater.should_receive(:file).with("simple_bot/spec/simple_bot/simple_bot_spec.rb", "player_spec.template", anything)

    templater.generate
  end

end