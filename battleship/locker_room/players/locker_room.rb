module LockerRoom

  prop_reader :player_list, :profile

  def players=(players)
    player_list.build do
      players.each do |player|
        __install "locker_room/player_list_item.rb", :player => player
      end
    end
  end

end