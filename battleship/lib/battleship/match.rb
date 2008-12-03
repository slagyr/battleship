require 'battleship/game'
require 'battleship/simple_player'
require 'battleship/server'

module Battleship

  class Match

    attr_reader :wins_required, :player1, :player2, :ui, :winner

    def initialize(wins_required, player1, player2, ui)
      @wins_required = wins_required
      @player1 = player1
      @player2 = player2
      @ui = ui
    end

    def begin
      begin
        @player1_wins = 0
        @player2_wins = 0
        @ui.update_stats "#{@player1_wins} : #{@player2_wins}"
        while @player1_wins < @wins_required && @player2_wins < @wins_required
          prepare_game
          play
          record_win
          @ui.update_stats "#{@player1_wins} : #{@player2_wins}"
          sleep(1)
        end
        @winner = @player1_wins == @wins_required ? @player1 : @player2
      rescue Exception => e
        @ui.exception(e)
      end

    end

    def play
      begin
        @game.prepare
        @game.play
        Server.submit_game(@game)
      rescue Exception => e
        @ui.exception(e)
      end
    end

    def players_reversed?
      return false unless @in_match
      return (@player1_wins + @player2_wins) % 2 == 1
    end

    def player1_instance
      @player1_instance = @player1.create_player if @player1_instance.nil?
      return @player1_instance
    end

    def player2_instance
      @player2_instance = @player2.create_player if @player2_instance.nil?
      return @player2_instance
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

    def prepare_game
      @ui.reset
      begin
        if players_reversed?
          @game = Game.new(@player2.name, player2_instance, @ui.war_room2, @player1.name, player1_instance, @ui.war_room1)
        else
          @game = Game.new(@player1.name, player1_instance, @ui.war_room1, @player2.name, player2_instance, @ui.war_room2)
        end
      rescue Exception => e
        @ui.exception(e)
      end
    end

  end
end