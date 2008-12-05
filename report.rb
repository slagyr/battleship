$: << File.expand_path(File.dirname(__FILE__) + "/battleship/lib")
require 'rubygems'
require 'battleship/player_profile'
require 'battleship/mock_battle_stations'
require 'battleship/round_robin'

$USE_SERVER = true
players = Battleship::PlayerProfile.player_hash
#puts "Player Name, Battle Score, Battle Description, Simplicity Score, Simplicity Description, Coverage Score, Coverage Description, Flog Score, Flog Description, Saikuro Score, Saikuro Description, Flay Score, Flay Description, Average Score"
#players.values.each do |player|
#  puts [player.name, player.battle_score, player.battle_description, player.simplicity_score, player.simplicity_description, player.coverage_score, player.coverage_description, player.flog_score, player.flog_description, player.saikuro_score, player.saikuro_description, player.flay_score, player.flay_description, player.average_score].join(", ")
#end

root_dir = File.expand_path(File.dirname(__FILE__) + "/tournament_results")
match_dirs = Dir.entries(root_dir) - ['..', '.', 'rounds.txt']
matches = []
match_dirs.each do |match_dir|
  match_file = File.join(root_dir, match_dir, "match.yml")
  yml = IO.read(match_file)
  match = YAML.load(yml)
  matches << match
end

names = []
matches.each do |match|
  names << match[:player1] unless names.include?(match[:player1])
end
names = names.sort { |a, b| players[a].wins <=> players[b].wins }
names.reverse!

puts "x, #{names.join(", ")}"

def find_match(matches, p1, p2)
  return matches.find { |match| (match[:player1] == p1 && match[:player2] == p2) || (match[:player1] == p2 && match[:player2] == p1) }
end

results = {}
names.each do |player|
  player_matches = []
  results[player] = player_matches
  names.each do |opponent|
    if player != opponent
      match = find_match(matches, player, opponent)
      if match
        player_matches << "#{match[:stats]} - #{match[:winner] == player ? 'w' : 'l'}"
      else
        player_matches << "not found"
      end
    else
      player_matches << "-"
    end 
  end
 puts "#{player}, #{player_matches.join(", ")}"
end

