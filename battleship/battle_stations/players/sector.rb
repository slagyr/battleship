module Sector

  attr_accessor :index

  def sectors
    return parent
  end

  def mouse_entered(e)
    sectors.sector_entered(self)
  end

  def mouse_clicked(e)
    sectors.sector_clicked(self)   
  end

  ROWS = %w{ A B C D E F G H I J }
  def coordinates
    row = ROWS[@index / 10]
    col = @index % 10 + 1
    return "#{row}#{col}"
  end

  def slope_to(sector)
    other_index = sector.index
    dx = (other_index % 10) - (@index % 10)
    dy = (@index / 10) - (other_index / 10)
    return (dy < 0 ? -100 : 100 ) if dx == 0
    return dy.to_f / dx.to_f
  end

  def right
    return nil if (@index % 10 == 9)
    return parent.children[@index + 1]
  end

  def down
    return nil if (@index > 89)
    return parent.children[@index + 10]
  end

  def highlight
    style.background_color = "#0F09"
  end

  def unhighlight
    style.background_color = "transparent"
  end

end