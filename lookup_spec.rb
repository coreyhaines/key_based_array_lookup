class CellsByLocation
  def at_location(location, &block)
  end
end

describe "Looking up cells by location" do
  context "when no cells have been added" do
    it "does not call the callback" do
      cells = CellsByLocation.new
      expect { |b| cells.at_location(Object.new, &b) }.not_to yield_control
    end
  end
end
