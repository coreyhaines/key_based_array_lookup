class CellsByLocation
  def initialize
    @cells = []
  end

  def at_location(location, &block)
    @cells.each { |l| l.(location, &block) }
  end

  def set(cell, location)
    @cells << ->(loc, &block) do
      loc.at?(location) { block.(cell) }
    end
  end
end

class Cell
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

describe "Looking up cells by location" do
  context "when no cells have been added" do
    it "does not call the callback" do
      cells = CellsByLocation.new
      expect { |b| cells.at_location(Object.new, &b) }.not_to yield_control
    end
  end

  context "when a cell has been added" do
    context "and you ask for it by its location" do
      it "sends the cell to you" do
        cells = CellsByLocation.new
        cell = Cell.new
        location = Location.new 1, 1
        cells.set cell, location
        expect { |b| cells.at_location(location, &b) }.to yield_with_args(cell)
      end
    end

    context "and you ask for it by a different location" do
      it "does not send the cell to you" do
        cells = CellsByLocation.new
        cell = Cell.new
        location = Location.new 1, 1
        cells.set cell, location
        expect { |b| cells.at_location(Location.new(2,1), &b) }.not_to yield_control
      end
    end
  end
end
