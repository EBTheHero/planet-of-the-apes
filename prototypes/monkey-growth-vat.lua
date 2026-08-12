local growth_vat = table.deepcopy(data.raw["assembling-machine"]["biochamber"]);

growth_vat.name = "growth-vat"
growth_vat.localised_name ="growth-vat"

growth_vat.crafting_categories = {"monkey-breeding"}
growth_vat.module_slots = 0
growth_vat.effect_receiver = {}
growth_vat.fixed_recipe = "monkey-accelerated-growth"

data:extend({
    growth_vat,
});

local growth_vat_item = table.deepcopy(data.raw["item"]["biochamber"]);

growth_vat_item.name = "growth-vat"
growth_vat_item.place_result = "growth-vat"

data:extend({
    growth_vat_item,
});
