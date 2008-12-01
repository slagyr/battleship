require 'battleship/game'
require 'battleship/simple_player'

module BattleStations

  prop_reader :war_room1, :war_room2, :stats

  def play
    war_room1.reset
    war_room2.reset
    begin
      game = Battleship::Game.new(@player1.name, @player1.create_player, war_room1, @player2.name, @player2.create_player, war_room2)
    rescue Exception => e
      scene.stage.alert(e.to_s + "\n" + e.backtrace[0..10].join("\n") + "\n...")
    end

    Thread.new do
      begin
        game.prepare
        game.play 
      rescue Exception => e
        scene.stage.alert(e.to_s + "\n" + e.backtrace[0..10].join("\n") + "\n...")
      end
      game_complete(game)
    end
  end

  def player1=(player)
    @player1 = player
  end

  def player2=(player)
    @player2 = player
  end

  def battle_again
    hide_actions
    play
  end

  def begin_match
    @in_match = true
    @player1_wins = 0
    @player2_wins = 0
    process_match
  end

  def process_match
    stats.text = "#{@player1_wins} : #{@player2_wins}"
    if @player1_wins == 11 || @player2_wins == 11
      @in_match = false
    else
      play
    end
  end

  def game_complete(game)
    if game.player1_winner?
      @player1_wins += 1
    else
      @player2_wins += 1
    end
    sleep(1)
    process_match
    show_actions if !@in_match
  end

  def hide_actions
    find_by_name("action_link").each { |link| link.style.width = "0"; link.style.border_color = "transparent" }
  end

  def show_actions
    find_by_name("action_link").each { |link| link.style.width = "auto"; link.style.border_color = "white" }
  end

end