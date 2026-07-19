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
    type = 'recipe',
    name = 'monkey',
    icon      =  "__base__/graphics/icons/small-biter.png",
    enabled = true,
    categories = {'monkey-breeding'},
    ingredients = {
      },

    --results = {{type = 'item', name = 'monkey', amount = 1}},
    results = {},
    energy_required = 1,
  },

})



local test_spoil = table.deepcopy(data.raw["car"]["tank"]);

test_spoil.name = "test_spoil"
test_spoil.minable = {mining_time = 0.4, result = "test_spoil_item"}

data:extend({
    test_spoil,
});

local test_spoil_item = table.deepcopy(data.raw["item-with-entity-data"]["tank"]);

test_spoil_item.name = "test_spoil_item"
test_spoil_item.spoil_result = "test_spoilED_item"
test_spoil_item.spoil_ticks = 60*60
test_spoil_item.spoil_result = "test_spoilED_item"

test_spoil_item.place_result = "test_spoil"

data:extend({
    test_spoil_item,
});

local test_spoilED = table.deepcopy(data.raw["car"]["tank"]);

test_spoilED.name = "test_spoilED"
test_spoilED.minable = {mining_time = 0.4, result = "test_spoilED_item"}

data:extend({
    test_spoilED,
});

local test_spoilED_item = table.deepcopy(data.raw["item-with-entity-data"]["tank"]);

test_spoilED_item.name = "test_spoilED_item"
test_spoilED_item.place_result = "test_spoilED"

data:extend({
    test_spoilED_item,
});