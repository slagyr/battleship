options do
  option :text => "Go to Locker Room", :on_mouse_clicked => "scene.load('locker_room').players = production.computer_players"
  option :text => "Human vs Human"
  option :text => "Human vs Computer"
  option :text => "Computer vs Computer", :on_mouse_clicked => "scene.load('battle_stations').play"
end
