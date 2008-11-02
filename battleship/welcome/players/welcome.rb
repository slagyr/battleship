module Welcome

  def begin_game
    battle_stations = scene.load('battle_stations')
    battle_stations.player1 = player1.create_player
    battle_stations.player2 = player2.create_player
    battle_stations.play
  end

  def player1
    name = find("player1_selection").value
    return production.computer_players[name]
  end

  def player2
    name = find("player2_selection").value  
    return production.computer_players[name]
  end

end