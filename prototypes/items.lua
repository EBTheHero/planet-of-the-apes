local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({

    {
    type = 'item-with-tags',
    name = 'monkey',
    
    
    icon      =  "__base__/graphics/icons/big-biter.png",
    icon_size =  64     ,
    subgroup  = 'energy',
    order     = 'z'     ,
    stack_size   =  1     ,

    -- The weight (in grams) determines how many fit on a rocket.
    weight = 1000
    },
              {
    type = 'item-with-tags',
    name = 'tired-monkey',
    
    
    icon      =  "__base__/graphics/icons/small-biter.png",
    icon_size =  64     ,
    subgroup  = 'energy',
    order     = 'z'     ,
    
    stack_size   =  1     ,

    -- The weight (in grams) determines how many fit on a rocket.
    weight = 1000,
    },

    {
    type = "item",
    name = "novella",
    icon = "__planet-of-the-apes__/sprite/icons/novella.png",
    subgroup = "production-machine",
    color_hint = { text = "1" },
    order = "z",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 100,
  },
{
    type = "item",
    name = "creative-work",
    icon = "__planet-of-the-apes__/sprite/icons/creative-work.png",
    subgroup = "intermediate-product",
    color_hint = { text = "1" },
    order = "a[basic-intermediates]-a[iron-gear-wheel]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 100,
  },
  {
    type = "item-with-tags",
    name = "monkey-embryon",
    icon = "__planet-of-the-apes__/sprite/icons/Periodic Madness - bacteriaed-petri-dish.png",
    subgroup = "intermediate-product",
    color_hint = { text = "1" },
    order = "a[basic-intermediates]-a[iron-gear-wheel]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 1,
    spoil_ticks = 60 * 60 * 5,
    spoil_result = "spoilage"
  },
    {
    type = "item",
    name = "petri-dish",
    icon = "__planet-of-the-apes__/sprite/icons/Periodic Madness - empty-petri-dish.png",
    subgroup = "intermediate-product",
    color_hint = { text = "1" },
    order = "a[basic-intermediates]-a[iron-gear-wheel]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 100
  },
    {
    type = "item",
    name = "sand",
    icon = "__planet-of-the-apes__/sprite/icons/Moshine - sand-3.png",
    subgroup = "intermediate-product",
    color_hint = { text = "1" },
    order = "a[basic-intermediates]-a[iron-gear-wheel]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 100
  },
    {
    type = "item",
    name = "glass",
    icon = "__planet-of-the-apes__/sprite/icons/Moshine - glass.png",
    subgroup = "intermediate-product",
    color_hint = { text = "1" },
    order = "a[basic-intermediates]-a[iron-gear-wheel]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 100
  },

})

--recipes
data:extend({
  {
    type = 'recipe',
    name = 'novella',
    icon      = "__planet-of-the-apes__/sprite/icons/novella.png",
    enabled = true,
    categories = {'monkey-breeding'},
    ingredients = {{type="item", name="wood", amount=1}
      },

    --results = {{type = 'item', name = 'monkey', amount = 1}},
    results = {{type = "item", name = "novella", amount = 1}},
    energy_required = 20,
    raise_on_crafted = true,
  },
    {
    type = 'recipe',
    name = 'creative-work',
    icon      =  "__planet-of-the-apes__/sprite/icons/creative-work.png",
    enabled = true,
    ingredients = {{type="item", name="novella", amount=10, quality_min = "legendary"}
      },

    results = {{type = "item", name = "creative-work", amount = 1}},
    energy_required = 1,
  },
{
    type = 'recipe',
    name = 'petri-dish',
    categories = {"crafting"},
    icon      =  "__planet-of-the-apes__/sprite/icons/Periodic Madness - empty-petri-dish.png",
    enabled = true,
    ingredients = {{type="item", name="glass", amount=1}
      },

    results = {{type = "item", name = "petri-dish", amount = 2}},
    energy_required = 1,
},
{
    type = 'recipe',
    name = 'sand',
    enabled = true,
    categories = {"crafting"},
    ingredients = {{type="item", name="stone", amount=1}
      },

    results = {{type = "item", name = "sand", amount = 2}},
    energy_required = 1,
},
    {
    type = 'recipe',
    name = 'monkey-embryon',
    icon      =  "__planet-of-the-apes__/sprite/icons/Periodic Madness - bacteriaed-petri-dish.png",
    enabled = true,
    categories = {'monkey-breeding'},
    ingredients = {
        {type="item", name = "petri-dish", amount = 1}
      },

    --results = {{type = 'item', name = 'monkey', amount = 1}},
    results = {},
    energy_required = 1,
    raise_on_crafted = true,
  },
      {
    type = 'recipe',
    name = 'monkey-accelerated-growth',
    icon      =  "__base__/graphics/icons/big-biter.png",
    enabled = true,
    categories = {"monkey-breeding"},
    ingredients = {
        {type="item", name = "monkey-embryon", amount = 1}
      },

    results = {{type = 'item', name = 'monkey', amount = 1}},
    --results = {},
    energy_required = 60,
    overload_multiplier = 1,
    maximum_productivity = 0,
    raise_on_crafted = true,
  },
})



if not data.raw.recipe["glass"] then
  data:extend({
    {
      type = "recipe",
      name = "glass",
      categories = {"smelting"},
      energy_required = 4,
      ingredients = {
        {type = "item", name = "sand", amount = 4}
      },
      results = {{type = "item", name = "glass", amount = 1}},
      allow_productivity = true,
      enabled = true,
    },
  })
end