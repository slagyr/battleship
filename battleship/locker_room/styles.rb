
locker_room {
  background_color :black
  secondary_background_color :gray
  gradient_angle 270
  gradient :on
  horizontal_alignment :center
  vertical_alignment :center
  width 1000
  height 700
}

column {
  width "50%"
  height "100%"
  margin 5
}

title {
  width "100%"
  horizontal_alignment :center
  text_color :white
  font_size 25
  font_face :courier_new
}

profile {
  width "100%"
  height "100%"
  left_border_width 2
  left_border_color :grey
  left_padding 5
}

stat_label {
  width "20%"
  text_color :white
  font_size 12
  font_face :courier_new
  font_style :bold
  top_margin 10
}

stat_result {
  width "80%"
  top_margin 10
  left_margin 10
  text_color :white
  font_size 16
  font_face :courier_new
  max_height 200
}

result_graph {
  width "100%"
  height 30
  border_color :dark_gray
  border_width 3
  rounded_corner_radius 4
  background_color :white
}

result_graph_bar {
  background_color :green
  width "100%"
  height "100%"
}

result_graph_text {
  float :on
  width "100%"
  height "100%"
  x 0
  y 0
  text_color :black
  font_size 12
  font_face :courier_new
  horizontal_alignment :center
  vertical_alignment :center
}


player_list {
  vertical_scrollbar :on
  width "100%"
  height 600
}

player_list_item {
  width "100%"
  border_color :grey
  border_width 2
  rounded_corner_radius 4
  margin 5
  padding 5
}

player_text {
  text_color :white
  font_face :courier_new
  font_size 16
}

player_name {
  extends :player_text
  width "80%"
}

player_score {
  extends :player_text
  width "20%"
}

buttons {
  width "100%"
  top_padding 10
  horizontal_alignment :right
}

evaulate_button {
  border_width 2
  border_color "red"
  rounded_corner_radius 4
  background_color :transparent
  text_color :red
  font_size 16
  font_face "courier_new"
  padding 5
  horizontal_alignment :center
  hover {
    background_color :white
  }
}

action_link {
  text_color :white
  font_size 20
  font_face :arial
  left_padding 20
  right_padding 20
  left_margin 20
  right_margin 20
  border_color :white
  border_width 2
  rounded_corner_radius 4
}

main_menu_link {
  extends :action_link
  hover {
    border_color :blue
  }
}

actions {
  width "100%"
  top_margin 20
}