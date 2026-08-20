local monkey_workstation =
	table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])

monkey_workstation.name = "monkey-workstation"
monkey_workstation.localised_name = "monkey_workstation"

monkey_workstation.crafting_categories = { "monkey-workstation-exclusive" }
monkey_workstation.module_slots = 0
monkey_workstation.fixed_recipe = "novella"

monkey_workstation.allowed_module_categories = nil
monkey_workstation.minable =
	{ mining_time = 0.5, result = "monkey-workstation" },
	-- Hide alt view modules
	-- monkey_workstation.icons_positioning =   {
	-- {inventory_index = defines.inventory.crafter_modules, shift = {0, 0.9}}
	-- }
	data:extend({
		monkey_workstation,
	})

local monkey_workstation_item =
	table.deepcopy(data.raw["item"]["assembling-machine-3"])

monkey_workstation_item.name = "monkey-workstation"
monkey_workstation_item.place_result = "monkey-workstation"

data:extend({
	monkey_workstation_item,
})

local my_thing_registration = {
	name = "monkey-workstation",
	intercept_construction = true,
	virtualize_orientation = 7, --"d8_R",
	--- @type things.ThingRegistration.Child[]
	children = {
		{
			create = {
				name = "monkey-slot",
				position = { 0, 0 },
				snap_to_grid = false,
			},
			offset = { x = -0, y = 2 },
			lifecycle_type = "void-real",
		},
	},
	custom_events = {
		on_status = "on_status",
		on_initialized = "on_initialized",
	},
}

data.raw["mod-data"]["things-names"].data["monkey-workstation"] =
	my_thing_registration
