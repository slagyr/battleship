# This file (init.rb) is the second file loaded (after production.rb) when a production is loaded.
# Initialization code for the production should go here.

# If your production is using external ruby source code that will be required in player modules, you may
# add the path to $: here.
$: << File.expand_path(File.dirname(__FILE__) + "/lib")

# Acquires a reference to the production.
production = Limelight::Production["."]

# Require any source code that will be used by the production.
#require 'seomthing'

# This is the ideal place to assign values to production attributes.
require 'battleship/player_profile'
players = Battleship::PlayerProfile.load_all
player_hash = {}
players.each { |p| player_hash[p.name] = p }
production.computer_players = player_hash
