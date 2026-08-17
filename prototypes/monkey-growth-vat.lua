local growth_vat = table.deepcopy(data.raw["assembling-machine"]["biochamber"])

growth_vat.name = "growth-vat"
growth_vat.localised_name = "growth-vat"

growth_vat.crafting_categories = { "monkey-breeding" }
growth_vat.module_slots = 3
growth_vat.allowed_effects = { "speed", "consumption", "pollution" }
growth_vat.effect_receiver = {}
growth_vat.fixed_recipe = "monkey-accelerated-growth"
growth_vat.energy_usage = "50kW"
growth_vat.crafting_speed = 1

data:extend({
	growth_vat,
})

local growth_vat_item = table.deepcopy(data.raw["item"]["biochamber"])

growth_vat_item.name = "growth-vat"
growth_vat_item.place_result = "growth-vat"

data:extend({
	growth_vat_item,
})
