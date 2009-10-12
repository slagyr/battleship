options do
  # option :text => "Go to Locker Room", :on_mouse_clicked => "scene.load('locker_room').players = production.computer_players.values"

  player_selections do
    player_selection do
      player_selection_title :text => "Player 1"
      player_options :id => "player1_selection", :players => "combo_box"
    end
    player_selection do
      player_selection_title :text => "Player 2"
      player_options :id => "player2_selection", :players => "combo_box"
    end
  end

  option :text => "Battle Stations", :on_mouse_clicked => "scene.begin_game"
#  option :text => "Run Tournament", :on_mouse_clicked => "battle_stations = scene.load('battle_stations'); battle_stations.round_robin"
end
