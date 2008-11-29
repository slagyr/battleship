profile :id => "profile" do
  title :text => "Dossier"
  stat_label :text => "Player Name:"
  stat_result :text => "No player selected", :id => "player_name"

  stat_label :text => "Author:"
  stat_result :text => "No player selected", :id => "author_name"

  stat_label :text => "Description:"
  stat_result :text => "No player selected", :height => 100, :vertical_scrollbar => :on, :id => "description"

  stat_label :text => "Average Score:"
  stat_result do
    result_graph :id => "average_graph"
  end

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

  stat_label :text => "Saikuro Score:"
  stat_result do
    result_graph :id => "saikuro_graph"
  end

  stat_label :text => "Flay Score:"
  stat_result do
    result_graph :id => "flay_graph"
  end

  buttons do
    evaulate_button :id => "evaluate_button", :text => "Perform Analysis", :on_mouse_clicked => "scene.find('profile').perform_analysis"
  end
end