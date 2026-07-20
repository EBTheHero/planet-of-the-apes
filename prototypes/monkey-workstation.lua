local monkey_workstation = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"]);

monkey_workstation.name = "monkey-workstation"
monkey_workstation.localised_name ="monkey_workstation"

monkey_workstation.crafting_categories = {"monkey-breeding"}

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

