class CellsByLocation
  def initialize
    @cells = []
  end

  def at_location(location, &block)
    @cells.each(&block)
  end

  def set(cell, location)
    @cells << cell
  end
end

class Cell
end

class Location
  def initialize(x, y)
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
  end
end
