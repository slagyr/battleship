require 'battleship/round_robin'
require 'battleship/match'

module BattleStations

  prop_reader :war_room1, :war_room2, :stats

  def player1=(player)
    @player1 = player
  end

  def player2=(player)
    @player2 = player
  end

  def battle_again
    begin_match(1)
  end

  def begin_match(required_wins = 11)
    Thread.new do
      hide_actions
      match = Battleship::Match.new(required_wins, @player1, @player2, self)
      match.begin
      show_actions
    end
  end

  def update_stats(message)
    stats.text = message
  end

  def hide_actions
    find_by_name("action_link").each { |link| link.style.width = "0"; link.style.border_color = "transparent" }
  end

  def show_actions
    find_by_name("action_link").each { |link| link.style.width = "auto"; link.style.border_color = "white" }
  end

  def round_robin
    Thread.new do
      Battleship::RoundRobin.run(production.computer_players, self)
    end
  end

  def reset
    war_room1.reset
    war_room2.reset
  end

  def exception(e)
    scene.stage.alert(e.to_s + "\n" + e.backtrace[0..10].join("\n") + "\n...")
  end

end