items =  Array.new(100) do |i|
  { name: "name #{i}", rate: "#{i}" }
end
Item.seed(:name, items)