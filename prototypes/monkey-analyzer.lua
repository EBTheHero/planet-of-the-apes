local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local things_client = require("__0-things__.client.client") --[[@as things.client]]

local pipe_pictures = {
  north = {
    filename = "__planet-of-the-apes__/graphics/buildings/research-server/research-server-k-pipe-N.png",
    priority = "extra-high",
    width = 71,
    height = 38,
    shift = util.by_pixel(2.25, 13.5),
    scale = 0.5,
  },
  east = {
    filename = "__planet-of-the-apes__/graphics/buildings/research-server/research-server-k-pipe-E.png",
    priority = "extra-high",
    width = 42,
    height = 76,
    shift = util.by_pixel(-24.5, 1),
    scale = 0.5,
  },
  south = {
    filename = "__planet-of-the-apes__/graphics/buildings/research-server/research-server-k-pipe-S.png",
    priority = "extra-high",
    width = 88,
    height = 61,
    shift = util.by_pixel(0, -31.25),
    scale = 0.5,
  },
  west = {
    filename = "__planet-of-the-apes__/graphics/buildings/research-server/research-server-k-pipe-W.png",
    priority = "extra-high",
    width = 39,
    height = 73,
    shift = util.by_pixel(25.75, 1.25),
    scale = 0.5,
  },
}

data:extend({
  {
    type = "recipe",
    name = "monkey-analyzer",
    energy_required = 5,
    enabled = true,
    ingredients = {
      { type = "item", name = "advanced-circuit", amount = 5 },
    },
    results = { { type = "item", name = "monkey-analyzer", amount = 1 } },
  },
  {
    type = "item",
    name = "monkey-analyzer",
    icon = "__planet-of-the-apes__/graphics/icons/entities/research-server.png",
    subgroup = "production-machine",
    order = "f3",
    place_result = "monkey-analyzer",
    stack_size = 50,
  },
  {
    type = "container",
    name = "monkey-analyzer",
    icon = "__planet-of-the-apes__/graphics/icons/entities/research-server.png",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.5, result = "monkey-analyzer" },
    collision_box = { { -1.25, -1.25 }, { 1.25, 1.25 } },
    selection_box = { { -1.4, -1.4}, { 1.4, 1.4 } },
    crafting_categories = { "monkey-breeding" },
    crafting_speed = 1,
    ingredient_count = 6,
    module_slots = 2,
    allowed_effects = { "consumption", "speed", "productivity", "pollution", "quality" },

    max_health = 250,
    corpse = "medium-remnants",
    damaged_trigger_effect = hit_effects.entity(),
    resistances = {
      { type = "physical", percent = 20 },
      { type = "fire", percent = 20 },
    },
    open_sound = { filename = "__planet-of-the-apes__/sounds/buildings/open.ogg", volume = 1 },
    close_sound = { filename = "__planet-of-the-apes__/sounds/buildings/close.ogg", volume = 1 },
    picture =
    {
        layers = {
                {
                    filename = "__planet-of-the-apes__/graphics/buildings/research-server/research-server-edit.png",
                    priority = "high",
                    width = 256,
                    height = 256,
                    shift = { 0., -0.2 },
                    frame_count = 60,
                    line_length = 15,
                    animation_speed = 0.9,
                    scale = 0.5,
                },
                {
                    filename = "__planet-of-the-apes__/graphics/buildings/research-server/research-server-shadow.png",
                    priority = "high",
                    width = 256,
                    height = 256,
                    draw_as_shadow = true,
                    shift = { 0., -0.2 },
                    repeat_count = 60,
                    animation_speed = 0.9,
                    scale = 0.5,
                },
        },
    },

    water_reflection = {
        pictures = {
          filename = "__planet-of-the-apes__/graphics/buildings/research-server/research-server-reflection.png",
          priority = "extra-high",
          width = 40,
          height = 40,
          shift = util.by_pixel(0, 40),
          variation_count = 1,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false,
    },
    inventory_size = 1,
    inventory_type = "normal",
    circuit_connector = circuit_connector_definitions["chest"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
  },
})

local dummycombinator = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"]);

--local dummycombinator = things_client.combinators_v1.get_invisible_constant_combinator_prototype()

dummycombinator.name = "monkey-analyzer-combinator"
dummycombinator.selection_box = {{-0.0, -0.0}, {0.0, 0.0}}
dummycombinator.collision_box = {{-0, -0}, {0, 0}}
dummycombinator.integration_patch_render_layer = "object" -- make sure it's rendered on top
dummycombinator.flags = {"not-on-map", "not-deconstructable", "not-selectable-in-game"}
dummycombinator.sprites = nil
dummycombinator.draw_circuit_wires = false
dummycombinator.selectable_in_game = false
dummycombinator.collision_mask = nil
--dummycombinator.selection_box = {{-0, -0}, {0, 0}}

local dummycombinator_item = table.deepcopy(data.raw["item"]["constant-combinator"]);

dummycombinator_item.name = "monkey-analyzer-combinator"
dummycombinator_item.place_result = "monkey-analyzer-combinator"
dummycombinator_item.hidden = true
dummycombinator_item.hidden_in_factoriopedia = true


data:extend({
    dummycombinator,
    dummycombinator_item
});

---@type things.ThingRegistration
local comb_thing_registration = {
	name = "monkey-analyzer-combinator",
	intercept_construction = true,
  custom_events = {
    on_initialized = "on_initialized",
  }
}

data.raw["mod-data"]["things-names"].data["monkey-analyzer-combinator"] = comb_thing_registration


---@type things.ThingRegistration
local my_thing_registration = {
	name = "monkey-analyzer",
	intercept_construction = true,
  --- @type things.ThingRegistration.Child[]
  children = { 
    {
      create = {name = "monkey-analyzer-combinator", position = {0,0}, snap_to_grid = false},
      offset = {x = -1, y = 1},
      lifecycle_type = "void-real",
    },
  },
  custom_events = {
    on_status = "on_status",
    on_initialized = "on_initialized",
  }
}

data.raw["mod-data"]["things-names"].data["monkey-analyzer"] = my_thing_registration
