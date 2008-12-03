$: << File.expand_path(File.dirname(__FILE__) + "/battleship/lib")
require 'rubygems'
require 'battleship/player_profile'
require 'battleship/mock_battle_stations'
require 'battleship/round_robin'

$USE_SERVER = true
players = Battleship::PlayerProfile.player_hash
ui = Battleship::MockBattleStations.new
dir = File.expand_path(File.dirname(__FILE__) + "/#{Time.now.to_i}_rr_tournament")
Battleship::RoundRobin.run(players, ui, dir)