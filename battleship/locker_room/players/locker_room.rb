module LockerRoom

  def player_list
    @player_list = scene.find("player_list") if @player_list.nil?
    return @player_list
  end

  def profile
    @profile = scene.find("profile") if @profile.nil?
    return @profile
  end

  def players=(players)
    player_list.build do
      players.each do |player|
        __install "locker_room/player_list_item.rb", :player => player
      end
    end
  end

end