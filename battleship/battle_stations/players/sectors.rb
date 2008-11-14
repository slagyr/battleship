module Sectors

  attr_accessor :ships_hidden

  def place_ship(type, orientation, x, y)
    return if ships_hidden
    options = { :x => (x * 40 + 1), :y => (y * 40 + 1), :players => "image", :image => "images/#{type}.png" }
    options[:rotation] = 270.0 if orientation == :vertical
    self.build do
      ship options
    end
    sleep(0.25)
  end

  def miss(x, y)
    cell(x, y).color = "white"
    sleep(0.25)
  end

  def hit(x, y)
    cell(x, y).color = "red"
    sleep(0.25)
  end

  def reset
    self.find_by_name("ship").each { |ship| self.remove(ship) }
    self.children.each { |child| child.style.background_color = "transparent" }
  end

  attr_accessor :sector_listener

  private

  def cell(x, y)
    return children[x + y * 10]
  end

end