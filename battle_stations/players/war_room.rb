module WarRoom

  def commander=(name)
    @scene.find("#{id}_commander").text = name
  end

  def ship_statuses
    statuses = {}
    statuses[:carrier] = scene.find("#{id}_carrier_status")
    statuses[:battleship] = scene.find("#{id}_battleship_status")
    statuses[:destroyer] = scene.find("#{id}_destroyer_status")
    statuses[:submarine] = scene.find("#{id}_submarine_status")
    statuses[:patrolship] = scene.find("#{id}_patrolship_status")
    return statuses
  end

  def sectors
    return scene.find("#{id}_sectors")
  end

  def reset
    ship_statuses.values.each { |status| status.damaged(0) }
    sectors.reset
  end

end