# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

battle_stations {
  background_color :black
  secondary_background_color :gray
  gradient_angle 270
  gradient :on
  horizontal_alignment :center
#  vertical_alignment :center
  width 1000
  height 600
}

title {
  font_face "Krungthep"
  font_size 40
  text_color :white
  horizontal_alignment :center
  width "100%" 
}

war_room {
  width 500
  horizontal_alignment :center
}

war_room_title {
  font_face "Krungthep"
  font_size 30
  text_color :white
  horizontal_alignment :center    
  width "100%"
}

map {
  width 441
  height 441
}

cell {
  width 40
  height 40
}

column_header {
}

row_headers {
  width 40
  height 401
}

row_header {
}

header {
  horizontal_alignment :center
  vertical_alignment :center
  text_color :white
  font_face "Krungthep"
  font_size 20
}

sectors {
  width 401
  height 401
  border_color :green
  left_border_width 1
  top_border_width 1
  background_color "#3f7398"
  secondary_background_color "#48687f"
  gradient_angle 315
  gradient_penetration 5
  cyclic_gradient :on
  gradient :on
}

sector {
  border_color :green
  right_border_width 1
  bottom_border_width 1
}
