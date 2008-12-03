require 'battleship/game'
require 'battleship/simple_player'
require 'battleship/server'

module Battleship

  class Match

    attr_reader :wins_required, :player1, :player2, :ui, :winner
    attr_reader :games

    def initialize(wins_required, player1, player2, ui)
      @wins_required = wins_required
      @player1 = player1
      @player2 = player2
      @ui = ui
      @games = []
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
#          sleep(1)
        end
        if @player1_wins == @wins_required
          @winner = @player1
          @ui.match_winner @player1.name
        else
          @winner = @player2
          @ui.match_winner @player2.name
        end

      rescue Exception => e
        @ui.exception(e)
      end

    end

    def play
      begin
        @game.prepare
        @game.play
#p @game.to_hash
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
        @games << @game
      rescue Exception => e
        @ui.exception(e)
      end
    end

    def dir_name
      return "#{@player1.filename}_VS_#{@player2.filename}"   
    end

    def to_hash
      hash = {}
      hash[:player1] = @player1.name
      hash[:player2] = @player2.name
      hash[:winner] = @winner.name
      hash[:stats] = "#{@player1_wins} : #{@player2_wins}"
      return hash
    end

    def save(base_path)
      match_dir = File.join(base_path, dir_name)
      Dir.mkdir(match_dir)
      metafile = File.join(match_dir, "match.yml")
      File.open(metafile, "w") { |file| file.write YAML.dump(to_hash) }
      @games.each_with_index do |game, index|
        filename = File.join(match_dir, "game_#{index}.yml")
        hash = game.to_hash
        File.open(filename, "w") { |file| file.write YAML.dump(hash) }
      end
    end

  end
end