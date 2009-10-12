# This file (stages.rb) is used to define the stages within your production.
#
# Below is an example statge configuration.
#
#  stage "center_stage" do
#    default_scene "main"
#    title "Limelight Center Stage"
#    location [0, 0]
#    size [300, 800]
#  end

stage "default" do
  default_scene "welcome"
  title "Battleship"
  location :center, :center 
  size :auto, :auto
end
#
#stage "lab" do
#  default_scene nil
#  title "Player Lab"
#  location [0, 0]
#  size [300, 400]
#end
