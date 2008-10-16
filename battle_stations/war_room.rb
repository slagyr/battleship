war_room :id => "war_room#{@number}" do
  war_room_title :text => "Fleet ##{@number}"
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
    sectors do
      100.times do |i|
        sector :id => "war_room#{@number}_#{letter}_#{i}", :styles => "cell"
      end
    end
  end
end