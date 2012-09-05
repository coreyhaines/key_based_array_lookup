class CellsByLocation
  def initialize
    @cells_at_keys = []
  end

  def at_location(key, &block)
    @cells_at_keys.each { |maybe_this_key| maybe_this_key.(key, &block) }
  end

  def set(cell, here)
    @cells_at_keys << ->(key, &block) do
      key.eq?(here) { block.(cell) }
    end
  end
end


