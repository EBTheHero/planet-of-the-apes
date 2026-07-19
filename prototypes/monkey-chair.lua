local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local cr = require("__base__.prototypes.entity.circuit-network")

function make_4way_animation_from_spritesheet(animation)
  local function make_animation_layer(idx, anim)
    local frame_count = anim.frame_count or 1
    local start_frame = frame_count * idx
    local x = 0
    local y = 0
    if anim.line_length then
      y = anim.height * math.floor(start_frame / (anim.line_length or 1))
      if anim.line_length > frame_count then
        error("single line must not contain animations for multiple directions when line_lenght is specified: " .. anim.filename)
      end
    else
      x = idx * anim.width
    end
    return
    {
      filename = anim.filename,
      priority = anim.priority or "high",
      flags = anim.flags,
      x = x,
      y = y,
      width = anim.width,
      height = anim.height,
      frame_count = anim.frame_count,
      line_length = anim.line_length,
      repeat_count = anim.repeat_count,
      shift = anim.shift,
      draw_as_shadow = anim.draw_as_shadow,
      draw_as_glow = anim.draw_as_glow,
      draw_as_light = anim.draw_as_light,
      apply_runtime_tint = anim.apply_runtime_tint,
      tint_as_overlay = anim.tint_as_overlay or false,
      animation_speed = anim.animation_speed,
      scale = anim.scale or 1,
      tint = anim.tint,
      blend_mode = anim.blend_mode,
      load_in_minimal_mode = anim.load_in_minimal_mode,
      premul_alpha = anim.premul_alpha,
      generate_sdf = anim.generate_sdf
    }
  end

  local function make_animation(idx)
    if animation.layers then
      local tab = { layers = {} }
      for k,v in ipairs(animation.layers) do
        table.insert(tab.layers, make_animation_layer(idx, v))
      end
      return tab
    else
      return make_animation_layer(idx, animation)
    end
  end

  return
  {
    north = make_animation(0),
    east = make_animation(1),
    south = make_animation(2),
    west = make_animation(3)
  }
end

function generate_constant_combinator(combinator)
  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          scale = 0.5,
          filename = "__base__/graphics/entity/combinator/constant-combinator.png",
          width = 114,
          height = 102,
          shift = util.by_pixel(0, 5)
        },
        {
          scale = 0.5,
          filename = "__base__/graphics/entity/combinator/constant-combinator-shadow.png",
          width = 98,
          height = 66,
          shift = util.by_pixel(8.5, 5.5),
          draw_as_shadow = true
        }
      }
    })
  combinator.activity_led_sprites =
  {
    north = util.draw_as_glow
    {
      scale = 0.5,
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-N.png",
      width = 14,
      height = 12,
      shift = util.by_pixel(9, -11.5)
    },
    east = util.draw_as_glow
    {
      scale = 0.5,
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-E.png",
      width = 14,
      height = 14,
      shift = util.by_pixel(7.5, -0.5)
    },
    south = util.draw_as_glow
    {
      scale = 0.5,
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-S.png",
      width = 14,
      height = 16,
      shift = util.by_pixel(-9, 2.5)
    },
    west = util.draw_as_glow
    {
      scale = 0.5,
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-W.png",
      width = 14,
      height = 16,
      shift = util.by_pixel(-7, -15)
    }
  }
  combinator.circuit_wire_connection_points =
  {
    {
      shadow =
      {
        red = util.by_pixel(7, -6),
        green = util.by_pixel(23, -6)
      },
      wire =
      {
        red = util.by_pixel(-8.5, -17.5),
        green = util.by_pixel(7, -17.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(32, -5),
        green = util.by_pixel(32, 8)
      },
      wire =
      {
        red = util.by_pixel(14.5, -16.5),
        green = util.by_pixel(17.5, -3.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(25, 20),
        green = util.by_pixel(9, 20)
      },
      wire =
      {
        red = util.by_pixel(9, 7.5),
        green = util.by_pixel(-6.5, 7.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(1, 11),
        green = util.by_pixel(1, -2)
      },
      wire =
      {
        red = util.by_pixel(-13.5, -0.5),
        green = util.by_pixel(-16.5, -13.5)
      }
    }
  }
  return combinator
end

data:extend({
    
          {
    type = 'item',
    name = 'monkey-chair',
    
    
    icon      =  "__base__/graphics/icons/steel-chest.png",
    icon_size =  64     ,
    subgroup  = 'energy',
    order     = 'z'     ,
    
    place_result = 'monkey-chair',

    stack_size   =  50     ,

    weight = 1000
    },
    {
    type = "container",
    name = "monkey-chair",
    icon = "__base__/graphics/icons/steel-chest.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.2, result = "monkey-chair"},
    max_health = 350,
    corpse = "steel-chest-remnants",
    dying_explosion = "steel-chest-explosion",
    open_sound = sounds.metallic_chest_open,
    close_sound = sounds.metallic_chest_close,
    inventory_type = "normal",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.25, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "container",
    inventory_size = 1,
    impact_category = "metal",
    icon_draw_specification = {scale = 0.7},
    picture =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/steel-chest/steel-chest.png",
          priority = "extra-high",
          width = 64,
          height = 80,
          shift = util.by_pixel(-0.25, -0.5),
          scale = 0.5
        },
        {
          filename = "__base__/graphics/entity/steel-chest/steel-chest-shadow.png",
          priority = "extra-high",
          width = 110,
          height = 46,
          shift = util.by_pixel(12.25, 8),
          draw_as_shadow = true,
          scale = 0.5
        }
      }
    }
  }
})

