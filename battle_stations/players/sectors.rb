module Sectors

  def place_ship(type, orientation, x, y)
    options = { :x => (x * 40 + 1), :y => (y * 40 + 1), :players => "image", :image => "images/#{type}.png" }
    options[:rotation] = 270.0 if orientation == :vertical
    self.build do
      ship options
    end
  end

  def miss(x, y)
    cell(x, y).style.background_color = "white"
  end

  def hit(x, y)
    cell(x, y).style.background_color = "red"
  end

  private

  def cell(x, y)
    return children[x*10 + y]
  end

end