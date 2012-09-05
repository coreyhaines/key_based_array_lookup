module NoReturn
  class LookupTable
    def initialize
      @cells_at_keys = []
    end

    def at(key, &block)
      @cells_at_keys.each { |maybe_here| maybe_here.(key, &block) }
    end

    def set(cell, here)
      @cells_at_keys << ->(key, &block) do
        key.eq?(here) { block.(cell) }
      end
    end
  end
end

