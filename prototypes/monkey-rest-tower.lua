data:extend({
    
          {
    type = 'item',
    name = 'rest-dummy',
    
    
    icon      =  "__base__/graphics/icons/arrows/signal-input.png",
    icon_size =  64     ,
    subgroup  = 'energy',
    order     = 'z'     ,
    stack_size   =  1,
    spoil_ticks = 5,
    spoil_to_trigger_result = {
        items_per_trigger = 1,
        trigger = {
          type = "area",
          radius = 15,
          trigger_target_mask = {"rest-target"},
          collision_mode = "distance-from-center",
          action_delivery = {
            type = "instant",
            target_effects = {{
              type = "script",
              effect_id = "rest-dummy-spoil"
              },
              {
              type = "create-explosion",
              entity_name = "water-splash"
              }
          
            }
          }
        }
      },

    -- The weight (in grams) determines how many fit on a rocket.
    weight = 1000
    },
    {
      type = 'recipe',
      name = 'rest-dummy',
      icon      =  "__base__/graphics/icons/arrows/signal-input.png",
      enabled = true,
      categories = {'monkey-breeding'},
      ingredients = {
        },

      results = {{type = 'item', name = 'rest-dummy', amount = 1, always_fresh = true}},
      
      energy_required = 1,
    },
    {
    type = 'item',
    name = 'rest-tower',
    place_result = "rest-tower",
    
    icon      =  "__base__/graphics/icons/arrows/signal-clockwise-circle-arrow.png",
    icon_size =  64     ,
    subgroup  = 'energy',
    order     = 'z'     ,
    
    stack_size   =  50     ,

    -- The weight (in grams) determines how many fit on a rocket.
    weight = 1000,
    },
    {
    type = 'recipe',
    name = 'rest-tower',
    icon      =  "__base__/graphics/icons/arrows/signal-clockwise-circle-arrow.png",
    enabled = true,
    categories = {'monkey-breeding'},
    ingredients = {
      },

    --results = {{type = 'item', name = 'monkey', amount = 1}},
    results = {},
    energy_required = 1,
  },

})

data:extend({
    {
      type = "trigger-target-type",
      name = "rest-target"
    }
});

local rest_tower = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"]);

rest_tower.name = "rest-tower"

rest_tower.crafting_categories = {"monkey-breeding"}
rest_tower.trash_inventory_size = 1
rest_tower.flags = {"placeable-player", "player-creation"}
rest_tower.radius_visualisation_specification =
{
  sprite =
  {
    filename = "__planet-of-the-apes__/sprites/rest-tower-radius-visualization.png",
    size = 500
  },
  distance = 15
}

rest_tower.allowed_effects = {}
rest_tower.module_slots = 0

data:extend({
    rest_tower,
});