module PlayerListItem

  attr_accessor :profile

  def mouse_clicked(e)
    scene.find('profile').profile = profile
  end

  def update
    score = profile.average_score
    style.border_color = profile.color_for_score(score)
    find_by_name('player_score')[0].text = score.to_s
  end

end