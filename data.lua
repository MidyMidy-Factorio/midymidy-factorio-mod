local uchest_item = {
    icon = "__base__/graphics/icons/wooden-chest.png",
    icon_mipmaps = 4,
    icon_size = 64,
    name = "unnoticeable-chest",
    order = "a[items]-a[unnoticeable-chest]",
    place_result = "unnoticeable-chest",
    stack_size = 10,
    subgroup = "storage",
    type = "item"
}

local uchest_entity = table.deepcopy(data.raw.container["wooden-chest"])
uchest_entity.name = "unnoticeable-chest"
uchest_entity.inventory_size = 512
uchest_entity.type = "linked-container"
uchest_entity.minable = {
    mining_time = 0.1, result = "unnoticeable-chest"
}

local uchest_recipe = {
    ingredients = {
        { "wood", 2 }
    },
    name = "unnoticeable-chest",
    result = "unnoticeable-chest",
    type = "recipe"
}

data:extend({uchest_item, uchest_entity, uchest_recipe})
