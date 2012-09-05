#Hash Lookups Are For Suckahs!

Want something that provides lookups for something, but you are sick and tired of using a hash? Or, you don't like to use return values, and hashes can't seem to give you the same options for calling a block with found values.

Here's a way to do it.

````
cells = CellsByLocation.new
cell1 = Cell.new
cell2 = Cell.new

cells.set cell1, Location.new(1, 1)
cells.set cell2, Location.new(1, 2)

cells.at_location(Location.new(1,1)) do |cell|
  puts "I FOUND CELL #{cell}"
end
````

