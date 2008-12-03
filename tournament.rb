$: << File.expand_path(File.dirname(__FILE__) + "/battleship/lib")
require 'rubygems'
require 'battleship/player_profile'
require 'battleship/mock_battle_stations'
require 'battleship/round_robin'

players = Battleship::PlayerProfile.player_hash
ui = Battleship::MockBattleStations.new
Battleship::RoundRobin.run(players, ui)