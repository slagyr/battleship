require 'battleship/game'
require 'battleship/simple_player'

module BattleStations

  prop_reader :war_room1, :war_room2

  def play
    hide_actions

    begin
      game = Battleship::Game.new(@player1.name, @player1.create_player, war_room1, @player2.name, @player2.create_player, war_room2)
      game.prepare
    rescue Exception => e
      scene.stage.alert(e.to_s + "\n" + e.backtrace[0..10].join("\n") + "\n...")
    end

    Thread.new do
      begin
        game.play
      rescue Exception => e
        scene.stage.alert(e.to_s + "\n" + e.backtrace[0..10].join("\n") + "\n...")
      end
      show_actions
    end
  end

  def player1=(player)
    @player1 = player
  end

  def player2=(player)
    @player2 = player
  end

  def battle_again
    war_room1.reset
    war_room2.reset
    play
  end

  def hide_actions
    remove(find("actions"))
  end

  def show_actions
    self.build do
      actions :id => "actions" do
        main_menu_link :text => "Back to Main Menu", :on_mouse_clicked => "scene.load('welcome')"
        battle_again_link :text => "Battle Again", :on_mouse_clicked => "scene.battle_again"
      end
    end
  end

end