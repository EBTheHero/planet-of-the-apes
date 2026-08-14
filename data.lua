local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local hit_effects = require("__base__.prototypes.entity.hit-effects")



require("prototypes.monkey")
require("prototypes.monkey-breeder")
require("prototypes.monkey-slot")
require("prototypes.monkey-analyzer")
require("prototypes.monkey-rest-tower")
require("prototypes.monkey-workstation")
require("prototypes.monkey-growth-vat")
require("prototypes.items")
require("prototypes.banana-tree")


--And these two make defining common file paths much shorter.
local function sprite(name)
  return '__planet-of-the-apes__/graphics/'..name
  end
  
local function sound(name)
  return '__planet-of-the-apes__/sound/'..name
  end

 

data:extend({

  {
  type = "recipe-category",
  name = "monkey-breeding"
}})
  


local no_base_connector_template = util.table.deepcopy(universal_connector_template)
no_base_connector_template. connector_main   = nil --remove base
no_base_connector_template. connector_shadow = nil --remove base shadow
  
local connector = circuit_connector_definitions.create_vector(no_base_connector_template,{{

  variation     = 25,
  main_offset   = util.by_pixel(7.0, -4.0), -- Converts pixels to tile fractions
  shadow_offset = util.by_pixel(7.0, -4.0), -- automatically for easier shifting.
  show_shadow   = true
  }})


data:extend({
  { type = "custom-event", name = "on_children_normalized" },
  { type = "custom-event", name = "on_child_status" },
  { type = "custom-event", name = "on_status" },
  { type = "custom-event", name = "on_initialized" },
})