war_room :id => "war_room#{@number}" do
  war_room_title :text => "Fleet ##{@number}"
  commander_name :id => "war_room#{@number}_commander", :text => "Anonymous"


  map do
    cell :text => " "
    %w{ 1 2 3 4 5 6 7 8 9 10 }.each do |number|
      column_header :text => number, :styles => "cell header"
    end
    row_headers do
      %w{ A B C D E F G H I J }.each do |letter|
        row_header :text => letter, :styles => "cell header"
      end
    end
    sectors :id => "war_room#{@number}_sectors" do
      100.times do |i|
        sector :styles => "cell"
      end
    end
  end

  status do
    ship_status :id => "war_room#{@number}_carrier_status" do
      status_title :text => "Carrier"
      ship_image :players => "image", :image => "images/carrier.png", :width => 100   
    end
    ship_status :id => "war_room#{@number}_battleship_status" do
      status_title :text => "Battleship"
      ship_image :players => "image", :image => "images/battleship.png", :width => 80
    end
    ship_status :id => "war_room#{@number}_destroyer_status" do
      status_title :text => "Destroyer"
      ship_image :players => "image", :image => "images/destroyer.png", :width => 60
    end
    ship_status :id => "war_room#{@number}_submarine_status" do
      status_title :text => "Submarine"
      ship_image :players => "image", :image => "images/submarine.png", :width => 60
    end
    ship_status :id => "war_room#{@number}_patrolship_status" do
      status_title :text => "Patrolship"
      ship_image :players => "image", :image => "images/patrolship.png", :width => 40
    end
  end
  
end