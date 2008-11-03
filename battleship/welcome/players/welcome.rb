module Welcome

  def scene_opened(e)
    close_curtains
    begin
      require 'battleship/player_profile'
      players = Battleship::PlayerProfile.load_from_gems
      player_hash = {}
      players.each { |p| player_hash[p.name] = p }
      production.computer_players = player_hash

      find("player1_selection").choices = player_hash.keys
      find("player2_selection").choices = player_hash.keys
      open_curtains
    rescue Exception => e
      puts e
      puts e.backtrace
      stage.alert("Could not load players!")
    end
  end

  def begin_game
    battle_stations = scene.load('battle_stations')
    battle_stations.player1 = player1
    battle_stations.player2 = player2
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

  private #################################################

  def close_curtains
    build do
      curtains :id => "curtains" do
        curtains_text :text => "Loading Players..."
      end
    end
  end

  def open_curtains
    remove(find("curtains"))
  end

end