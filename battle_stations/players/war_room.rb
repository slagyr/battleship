module WarRoom

  def commander=(name)
    @scene.find("#{id}_commander").text = name
  end

  def ship_statuses
    if @statuses.nil?
      @statuses = {}
      @statuses[:carrier] = scene.find("#{id}_carrier_status")
      @statuses[:battleship] = scene.find("#{id}_battleship_status")
      @statuses[:destroyer] = scene.find("#{id}_destroyer_status")
      @statuses[:submarine] = scene.find("#{id}_submarine_status")
      @statuses[:patrolship] = scene.find("#{id}_patrolship_status")
    end
    return @statuses
  end

  def sectors
    return scene.find("#{id}_sectors")
  end

  def victory!
    build do
      cover :border_color => "green" do
        cover_header :text => "Victory!", :text_color => "green"  
      end
    end
  end

  def defeat!
    build do
      cover :border_color => "red"  do
        cover_header :text => "Defeat", :text_color => "red"
      end
    end
  end

  def disqualified!(reason)
    build do
      cover :border_color => "red" do
        cover_header :text => "Disqualified", :text_color => "red"
        cover_text :text => reason, :text_color => "red"
      end
    end
  end

  def reset
    ship_statuses.values.each { |status| status.damaged(0) }
    sectors.reset
    find_by_name("cover").each { |cover| remove(cover) }
  end

end