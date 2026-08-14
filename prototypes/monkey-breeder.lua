local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local hit_effects = require("__base__.prototypes.entity.hit-effects")

data:extend({

    

    {
    type = "item",
    name = "monkey-breeder",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    subgroup = "production-machine",
    color_hint = { text = "1" },
    order = "a[assembling-machine-1]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    place_result = "monkey-breeder",
    stack_size = 50,
    random_tint_color = item_tints.iron_rust
  }
})

local monkey_breeder = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"]);

monkey_breeder.name = "monkey-breeder"

monkey_breeder.crafting_categories = {"monkey-breeding"}
monkey_breeder.trash_inventory_size = 1
monkey_breeder.fixed_recipe = "monkey-embryon"
monkey_breeder.collision_box = {{-1.2, -1.7}, {1.2, 1.7}}
monkey_breeder.selection_box = {{-1.5, -2}, {1.5, 1}}

monkey_breeder.next_upgrade = nil

data:extend({
    monkey_breeder,
});

---@type things.ThingRegistration
local my_thing_registration = {
	name = "monkey-breeder",
	intercept_construction = true,
  virtualize_orientation = 7, --"d8_R",
  --- @type things.ThingRegistration.Child[]
    children = { 
    {
      create = {name = "monkey-slot", position = {0,0},snap_to_grid = false},
      offset = {x = -1, y = 1.5},
      lifecycle_type = "void-real",
    },
    {
      create = {name = "monkey-slot", position = {0,0},snap_to_grid = false},
      offset = {x = 1, y = 1.5},
      lifecycle_type = "void-real",
    },
  },
  custom_events = {
    on_status = "on_status",
    on_initialized = "on_initialized",
  }
}

data.raw["mod-data"]["things-names"].data["monkey-breeder"] = my_thing_registration
