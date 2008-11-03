column do
  title :text => "Player List"
  player_list :id => "player_list"
  actions :id => "actions" do
    main_menu_link :text => "Back to Main Menu", :on_mouse_clicked => "scene.load('welcome')"
  end
end

column do
  __install "locker_room/profile.rb"
end