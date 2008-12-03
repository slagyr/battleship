require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/round_robin'

describe Battleship::RoundRobin do

  before(:each) do
    @tourny = Battleship::RoundRobin.new(["fred", "joe", "bill", "hector", "pete", "henry"])
  end

  it "should take a list of players" do
    tourny = Battleship::RoundRobin.new(["fred", "joe", "bill"])
    tourny.players.should == ["fred", "joe", "bill"]
  end

  it "should produce the right number of rounds" do
    Battleship::RoundRobin.new(["fred", "joe"]).rounds.length.should == 1
    Battleship::RoundRobin.new(["fred", "joe", "bill"]).rounds.length.should == 3
    Battleship::RoundRobin.new(["fred", "joe", "bill", "hector"]).rounds.length.should == 6
    Battleship::RoundRobin.new(["fred", "joe", "bill", "hector", "pete"]).rounds.length.should == 10
    Battleship::RoundRobin.new(["fred", "joe", "bill", "hector", "pete", "henry"]).rounds.length.should == 15
    Battleship::RoundRobin.new((1..13).to_a).rounds.length.should == 78
  end

  it "should randomize who starts first" do
    freds_rounds = @tourny.rounds.find_all { |round| round.include? "fred" }
    always_first = true
    freds_rounds.each do |round|
      if round[1] == "fred"
        always_first = false
        break
      end
    end

    always_first.should == false
  end

  it "should randomize order of rounds" do
    fred_first = true
    5.times do |i|
      fred_first = false if !@tourny.rounds[i].include?("fred")
    end

    fred_first.should == false
  end

end