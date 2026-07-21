local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({

    

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
  }

})