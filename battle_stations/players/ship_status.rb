module ShipStatus

  def self.extended(prop)
    prop.damage = 0    
  end

  attr_accessor :damage

  def damaged(percent)
    if(percent <= 50)
      style.background_color = "red"
      style.gradient_penetration = (percent * 2).to_s
      style.gradient = "on"
      style.gradient_angle = "0"
    elsif(percent < 100)
      style.background_color = "transparent"
      style.secondary_background_color = "red"
      style.gradient_penetration = ((100-percent) * 2).to_s
      style.gradient = "on"
      style.gradient_angle = "180"
    else
      style.background_color = "red"
      style.gradient = "off"
    end
   end
end