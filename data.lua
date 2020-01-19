local psi_emitter = table.deepcopy(data.raw.furnace["stone-furnace"])

psi_emitter.name = "psi-emitter"
psi_emitter.energy_source.emissions_per_minute = 1000
psi_emitter.placable_by = { item = "psi-emitter-item", count = 1 }
-- psi_emitter.order = "psi-emitter"

local item = table.deepcopy(data.raw.item["stone-furnace"])
item.name = "psi-emitter-item"
item.place_result = "psi-emitter"

local recipe = table.deepcopy(data.raw.recipe["stone-furnace"])
recipe.name = "psi-emitter"
recipe.result = "psi-emitter-item"

data:extend({psi_emitter, item, recipe})
