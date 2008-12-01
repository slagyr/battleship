control_panel :id => "control_panel" do
  button_panel :width => "30%" do
    action_link :text => "Back to Main Menu", :on_mouse_clicked => "scene.load('welcome')"
  end
  stats :id => "stats", :width => "30%", :text => "..."
  button_panel :width => "40%" do
    action_link :text => "Begin Battle", :on_mouse_clicked => "scene.battle_again"
    action_link :text => "Best of 21 Match", :on_mouse_clicked => "scene.begin_match"
  end
end