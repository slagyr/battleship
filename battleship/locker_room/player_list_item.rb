player_list_item :profile => @player, :border_color => @player.color_for_score(@player.average_score) do
  player_name :text => @player.name
  player_score :text => @player.average_score
end