-- data.raw.tree["tree-01"].placeable_by = { item = "wood", count = 2 }
-- data.raw.item["wood"].place_result = "tree-01"

data.raw.item["water-barrel"].place_as_tile = {
    result = "deepwater",
    condition = { "water-tile" },
    condition_size = 1
}
