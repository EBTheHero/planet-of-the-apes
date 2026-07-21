local monkey_workstation = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"]);

monkey_workstation.name = "monkey-workstation"
monkey_workstation.localised_name ="monkey_workstation"

monkey_workstation.crafting_categories = {"monkey-breeding"}
monkey_workstation.module_slots = 0

monkey_workstation.allowed_module_categories = {"beacon-interface--module-category"} 

-- Hide alt view modules
-- monkey_workstation.icons_positioning =   {
-- {inventory_index = defines.inventory.crafter_modules, shift = {0, 0.9}}
-- }

data:extend({
    monkey_workstation,
});

local monkey_workstation_item = table.deepcopy(data.raw["item"]["assembling-machine-3"]);

monkey_workstation_item.name = "monkey-workstation"
monkey_workstation_item.place_result = "monkey-workstation"



data:extend({
    monkey_workstation_item,
});


local beacon_interface = table.deepcopy(data.raw["beacon"]["beacon-interface--beacon-tile"])
beacon_interface.name =  "monkey-beacon-interface"
data:extend{beacon_interface}

