module ShipStatus

  def self.extended(prop)
    prop.damage = 0
  end

  attr_accessor :damage
  attr_reader :blinker

  def damaged(percent)
    @damage = percent
    if percent == 0
      style.background_color = "transparent"
      style.gradient = "off"
    elsif percent <= 50
      style.background_color = "red"
      style.secondary_background_color = "transparent"
      style.gradient_penetration = (percent * 2).to_s
      style.gradient = "on"
      style.gradient_angle = "0"
    elsif percent < 100
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

  def blink
    @toggle = true
    @blinker = animate(:updates_per_second => 2) do
      style.background_color = @toggle ? "green" : "transparent"
      @toggle = !@toggle
    end
  end

  def stop_blinking
    @blinker.stop
    style.background_color = "transparent"
  end
end