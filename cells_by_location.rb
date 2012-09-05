class CellsByLocation
  def initialize
    @cells_at_locations = []
  end

  def at_location(location, &block)
    @cells_at_locations.each { |maybe_this_location| maybe_this_location.(location, &block) }
  end

  def set(cell, location)
    @cells_at_locations << ->(loc, &block) do
      loc.at?(location) { block.(cell) }
    end
  end
end

class Location
  attr_accessor :x, :y
  def initialize(x, y)
    @x, @y = x, y
  end

  def at?(location, &block)
    location.same_x_y?(self.x, self.y, &block)
  end

  def same_x_y?(x, y, &block)
    block.call if self.x == x && self.y == y
  end
end

