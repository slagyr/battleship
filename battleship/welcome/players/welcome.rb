require 'battleship/human_profile'

module Welcome

  def scene_opened(e)
    load_players if production.computer_players.nil?
    player_names = production.computer_players.keys.sort
    player_names.unshift "Human"

    find("player1_selection").choices = player_names
    find("player2_selection").choices = player_names
  end

  def begin_game
    battle_stations = scene.load('battle_stations')
    battle_stations.player1 = player1
    battle_stations.player2 = player2
  end

  def player1
    name = find("player1_selection").value
    return player_for(name)
  end

  def player2
    name = find("player2_selection").value
    return player_for(name)
  end

  private #################################################

  def player_for(name)
    return Battleship::HumanProfile.instance if name == "Human"
    return production.computer_players[name]
  end

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

  def load_players
    close_curtains
    begin
      require 'battleship/player_profile'
      players = Battleship::PlayerProfile.load_from_gems
      player_hash = {}
      players.each { |p| player_hash[p.name] = p }
      production.computer_players = player_hash

      open_curtains
    rescue Exception => e
      puts e
      puts e.backtrace
      stage.alert("Could not load players!")
    end
  end

end