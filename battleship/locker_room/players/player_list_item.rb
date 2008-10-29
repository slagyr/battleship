module PlayerListItem

  attr_accessor :profile

  def mouse_clicked(e)
    scene.find('profile').profile = profile
  end

end