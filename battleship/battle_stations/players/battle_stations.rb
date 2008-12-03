require 'battleship/game'
require 'battleship/simple_player'
require 'battleship/server'
require 'battleship/round_robin'

module BattleStations

  prop_reader :war_room1, :war_room2, :stats

  def play
    begin
      @game.prepare
      @game.play
      Battleship::Server.submit_game(@game)
    rescue Exception => e
      scene.stage.alert(e.to_s + "\n" + e.backtrace[0..10].join("\n") + "\n...")
    end
  end

  def player1=(player)
    @player1 = player
  end

  def player2=(player)
    @player2 = player
  end

  def battle_again
    Thread.new do
      hide_actions
      @in_match = false
      prepare_game
      play
      show_actions if !@in_match
    end
  end

  def begin_match
    thread = Thread.new do
      hide_actions
      @in_match = true
      @player1_wins = 0
      @player2_wins = 0
      stats.text = "#{@player1_wins} : #{@player2_wins}"
      while @player1_wins != 11 && @player2_wins != 11
        prepare_game
        play
        record_win
        stats.text = "#{@player1_wins} : #{@player2_wins}"
        sleep(1)
      end
      @in_match = false
      puts "#{@player1.name}, #{@player1_wins}, #{@player2.name}, #{@player2_wins}"
      show_actions
    end
    return thread
  end

  def record_win
    player1_won = @game.player1_winner?
    player1_won = players_reversed? ? !player1_won : player1_won
    if player1_won
      @player1_wins += 1
    else
      @player2_wins += 1
    end
  end

  def hide_actions
    find_by_name("action_link").each { |link| link.style.width = "0"; link.style.border_color = "transparent" }
  end

  def show_actions
    find_by_name("action_link").each { |link| link.style.width = "auto"; link.style.border_color = "white" }
  end

  def round_robin
    Thread.new do
      tourny = Battleship::RoundRobin.new(production.computer_players.keys)
      tourny.rounds.each do |round|
        @player1 = production.computer_players[round[0]]
        @player2 = production.computer_players[round[1]]
        @player1_instance = nil
        @player2_instance = nil
        puts "# #{round[0]} vs #{round[1]}"
        match_thread = begin_match
        match_thread.join
      end
    end
  end

  def player1_instance
    @player1_instance = @player1.create_player if @player1_instance.nil?
    return @player1_instance
  end

  def player2_instance
    @player2_instance = @player2.create_player if @player2_instance.nil?
    return @player2_instance
  end

  def players_reversed?
    return false unless @in_match
    return (@player1_wins + @player2_wins) % 2 == 1
  end

  def prepare_game()
    war_room1.reset
    war_room2.reset
    begin
      if players_reversed?
        @game = Battleship::Game.new(@player2.name, player2_instance, war_room2, @player1.name, player1_instance, war_room1)
      else
        @game = Battleship::Game.new(@player1.name, player1_instance, war_room1, @player2.name, player2_instance, war_room2)
      end
    rescue Exception => e
      scene.stage.alert(e.to_s + "\n" + e.backtrace[0..10].join("\n") + "\n...")
    end
  end

end