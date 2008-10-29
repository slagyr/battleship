profile :id => "profile" do
  title :text => "Profile"
  stat_label :text => "Player Name:"
  stat_result :text => "blah", :id => "player_name"

  stat_label :text => "Author:"
  stat_result :text => "blathor blah", :id => "author_name"

  stat_label :text => "Description:"
  stat_result :text => ("blah " * 200), :height => 100, :vertical_scrollbar => :on, :id => "description"

  stat_label :text => "Battle Record:"
  stat_result do
    result_graph :id => "battle_graph"
  end

  stat_label :text => "Simplicity Score:"
  stat_result  do
    result_graph :id => "simplicity_graph"
  end

  stat_label :text => "Test Coverage Score:"
  stat_result do
    result_graph :id => "coverage_graph"
  end

  stat_label :text => "Flog Score:"
  stat_result do
    result_graph :id => "flog_graph"
  end
end