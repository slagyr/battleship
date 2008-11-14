module Sector

  attr_accessor :index

  def sectors
    return parent
  end

  def sector_listener
    return sectors.sector_listener
  end

  def color=(value)
    @desired_color = value
    style.background_color = value
  end

  def mouse_entered(e)
    begin
      sector_listener.sector_entered(self) if sector_listener
    rescue Exception => e
      puts e
      puts e.backtrace
    end
  end

  def mouse_clicked(e)
    sector_listener.sector_clicked(self) if sector_listener  
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
    return sectors.children[@index + 1]
  end

  def down
    return nil if (@index > 89)
    return sectors.children[@index + 10]
  end

  def highlight
    @desired_color = style.background_color
    style.background_color = "#0F09"
  end

  def unhighlight
    style.background_color = @desired_color
  end

end