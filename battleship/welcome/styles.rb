# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

welcome {
  background_color :black
  background_image "images/title_cover.png"
  background_image_fill_strategy :static
  width 740
  height 800
}

options {
  width "100%"
  height "100%"
  top_margin 400
  left_margin 100
  right_margin 100
  horizontal_alignment :center
}

option {
  width "100%"
  margin 20
  horizontal_alignment :center
  rounded_corner_radius 15

  text_color "#5cc31e"
  font_face :arial
  font_size 40
  
  hover {
    background_color :red
    secondary_background_color :transparent
    gradient_angle 0
    gradient_penetration 100
    gradient :on
  }
}

player_selection {
  width "50%"   
  horizontal_alignment :center
}

player_selection_title {
  text_color :white
  font_face :arial
  font_size 25
}

player_options {
  width "100%"
}