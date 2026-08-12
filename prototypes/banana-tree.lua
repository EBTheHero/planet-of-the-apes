local variation = {{
      trunk = {
        filename = "__planet-of-the-apes__/sprites/entity/banana-tree/banana-tree.png",
        flags = { "mipmap" },
        surface = "gleba",
        width = 1024,
        height = 1024,
        x = 0,
        y = 0,
        frame_count = 1,
        lines_per_file = 1,
        line_length = 1,
        shift = util.by_pixel(0, -75),
        scale = 0.33
      },
      leaves = {
        filename = "__planet-of-the-apes__/sprites/entity/banana-tree/leaves-transparent.png",
        flags = { "mipmap" },
        surface = "gleba",
        width = 1024,
        height = 1024,
        x = 0,
        y = 0,
                frame_count = 1,
        lines_per_file = 1,
        line_length = 1,
        shift = util.by_pixel(0, 0),
        scale = 0.33
      },
      shadow = {
        frame_count = 2,
        lines_per_file = 1,
        line_length = 2,
        flags = { "mipmap", "shadow" },
        surface = "gleba",
        filename = "__planet-of-the-apes__/sprites/entity/banana-tree/shadow.png",
        width = 1024,
        height = 1024,
        x = 0,
        y = 0,
        shift = util.by_pixel(80, -75),
        scale = 0.33
      },
    }
}

local banana_tree = table.deepcopy(data.raw["plant"]["tree-plant"]);

banana_tree.name = "banana-tree"
banana_tree.localised_name ="banana-tree"
banana_tree.growth_ticks = 5 * 60 * 60
banana_tree.variations = variation
banana_tree.growth_variations = nil
banana_tree.growth_mounds = {banana_tree.growth_mounds[1]}
banana_tree.minable.results = {{type = "item", name = "banana", amount = 50}},

data:extend({banana_tree})