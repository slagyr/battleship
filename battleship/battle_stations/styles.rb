# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

cell_width = 40
sectors_width = cell_width * 10 + 1
map_width = cell_width * 11 + 1

battle_stations {
  background_color :black
  secondary_background_color :gray
  gradient_angle 270
  gradient :on
  horizontal_alignment :center
#  vertical_alignment :center
  width 1200
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
  width 600
  height 530
  horizontal_alignment :center
}

war_room_title {
  font_face "Krungthep"
  font_size 25
  text_color :white
  horizontal_alignment :center    
  width "100%"
}

commander_name {
  font_face "Krungthep"
  font_size 30
  text_color :white
  horizontal_alignment :center
  width "100%"
}

map {
  width map_width
  height map_width
}

cell {
  width cell_width
  height cell_width
}

column_header {
}

row_headers {
  width cell_width
  height sectors_width
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
  width sectors_width
  height sectors_width
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

status {
  top_padding 0
  width 100
  height map_width
}

status_height = map_width / 5
ship_status {
  width "100%"
  height status_height
  top_margin status_height - 40
  left_margin 2
  vertical_alignment :center
  horizontal_alignment :center

  background_color :transparent
  secondary_background_color :transparent
  rounded_corner_radius 3
}

status_title {
  width "100%"
  horizontal_alignment :center
  font_face "Krungthep"
  font_size 12
  text_color :white
}

ship_image {
  height 20
}

ship {
  float :on
}

cover {
  width "100%"
  height "100%"
  float :on
  x 0
  y 0
  background_color :"#0009"
  border_width 3
  rounded_corner_radius 10
  left_margin 5
  right_margin 5
  horizontal_alignment :center
  vertical_alignment :center
}

cover_header {
  width "100%"
  horizontal_alignment :center
  font_face "Krungthep"
  font_size 55
}

cover_text {
  font_face "Krungthep"
  font_size 18
}