local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local item_effects = require("__space-age__.prototypes.item-effects")

data:extend({

	{
		type = "item-with-tags",
		name = "monkey",

		icon = "__base__/graphics/icons/big-biter.png",
		icon_size = 64,
		subgroup = "energy",
		order = "z",
		stack_size = 1,

		-- The weight (in grams) determines how many fit on a rocket.
		weight = 1000,
	},
	{
		type = "item-with-tags",
		name = "tired-monkey",
		auto_recycle = false,

		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 64,
		subgroup = "energy",
		order = "z",

		stack_size = 1,

		-- The weight (in grams) determines how many fit on a rocket.
		weight = 1000,
	},

	{
		type = "item",
		name = "novella",
		icon = "__planet-of-the-apes__/graphics/icons/novella.png",
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
		icon = "__planet-of-the-apes__/graphics/icons/creative-work.png",
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
		icon = "__planet-of-the-apes__/graphics/icons/Periodic Madness - bacteriaed-petri-dish.png",
		subgroup = "intermediate-product",
		color_hint = { text = "1" },
		order = "a[basic-intermediates]-a[iron-gear-wheel]",
		inventory_move_sound = item_sounds.mechanical_inventory_move,
		pick_sound = item_sounds.mechanical_inventory_pickup,
		drop_sound = item_sounds.mechanical_inventory_move,
		stack_size = 1,
		spoil_ticks = 60 * 60 * 5,
		spoil_result = "spoilage",
	},
	{
		type = "item",
		name = "petri-dish",
		icon = "__planet-of-the-apes__/graphics/icons/Periodic Madness - empty-petri-dish.png",
		subgroup = "intermediate-product",
		color_hint = { text = "1" },
		order = "a[basic-intermediates]-a[iron-gear-wheel]",
		inventory_move_sound = item_sounds.mechanical_inventory_move,
		pick_sound = item_sounds.mechanical_inventory_pickup,
		drop_sound = item_sounds.mechanical_inventory_move,
		stack_size = 100,
	},
	{
		type = "item",
		name = "sand",
		icon = "__planet-of-the-apes__/graphics/icons/Moshine - sand-3.png",
		subgroup = "intermediate-product",
		color_hint = { text = "1" },
		order = "a[basic-intermediates]-a[iron-gear-wheel]",
		inventory_move_sound = item_sounds.mechanical_inventory_move,
		pick_sound = item_sounds.mechanical_inventory_pickup,
		drop_sound = item_sounds.mechanical_inventory_move,
		stack_size = 100,
	},
	{
		type = "item",
		name = "glass",
		icon = "__planet-of-the-apes__/graphics/icons/Moshine - glass.png",
		subgroup = "intermediate-product",
		color_hint = { text = "1" },
		order = "a[basic-intermediates]-a[iron-gear-wheel]",
		inventory_move_sound = item_sounds.mechanical_inventory_move,
		pick_sound = item_sounds.mechanical_inventory_pickup,
		drop_sound = item_sounds.mechanical_inventory_move,
		stack_size = 100,
	},
	{
		type = "item",
		name = "banana",
		icon = "__planet-of-the-apes__/graphics/icons/banana-icon.png",
		subgroup = "intermediate-product",
		color_hint = { text = "1" },
		order = "a[basic-intermediates]-a[iron-gear-wheel]",
		inventory_move_sound = item_sounds.mechanical_inventory_move,
		pick_sound = item_sounds.mechanical_inventory_pickup,
		drop_sound = item_sounds.mechanical_inventory_move,
		stack_size = 100,
		spoil_ticks = 20 * 60 * 60, -- 20 minutes lmao
		spoil_result = "spoilage",
	},
	{
		type = "item",
		name = "banana-seed",
		icon = "__space-age__/graphics/icons/yumako-seed.png",
		subgroup = "intermediate-product",
		plant_result = "banana-tree",
		place_result = "banana-tree",
		color_hint = { text = "1" },
		order = "a[basic-intermediates]-a[iron-gear-wheel]",
		inventory_move_sound = item_sounds.mechanical_inventory_move,
		pick_sound = item_sounds.mechanical_inventory_pickup,
		drop_sound = item_sounds.mechanical_inventory_move,
		stack_size = 10,
	},
	{
		type = "capsule",
		name = "banana-mash",
		icon = "__space-age__/graphics/icons/yumako-mash.png",
		subgroup = "agriculture-products",
		order = "a[organic-processing]-c[yumako-mash]",
		inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
		pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
		drop_sound = space_age_item_sounds.agriculture_inventory_move,
		fuel_category = "chemical",
		fuel_value = "1MJ",
		stack_size = 100,
		spoil_ticks = 3 * minute,
		spoil_result = "spoilage",
		weight = 0.5 * kg,
		capsule_action = item_effects.yumako_regen,
	},
})

--recipes
data:extend({
	{
		type = "recipe",
		name = "novella",
		icon = "__planet-of-the-apes__/graphics/icons/novella.png",
		enabled = true,
		categories = { "monkey-workstation-exclusive" },
		ingredients = { { type = "item", name = "wood", amount = 1 } },

		--results = {{type = 'item', name = 'monkey', amount = 1}},
		results = { { type = "item", name = "novella", amount = 1 } },
		energy_required = 20,
		raise_on_crafted = true,
	},
	{
		type = "recipe",
		name = "creative-work",
		icon = "__planet-of-the-apes__/graphics/icons/creative-work.png",
		enabled = true,
		ingredients = {
			{
				type = "item",
				name = "novella",
				amount = 10,
				quality_min = "legendary",
			},
		},

		results = { { type = "item", name = "creative-work", amount = 1 } },
		energy_required = 1,
	},
	{
		type = "recipe",
		name = "petri-dish",
		categories = { "crafting" },
		icon = "__planet-of-the-apes__/graphics/icons/Periodic Madness - empty-petri-dish.png",
		enabled = true,
		ingredients = { { type = "item", name = "glass", amount = 1 } },

		results = { { type = "item", name = "petri-dish", amount = 2 } },
		energy_required = 1,
	},
	{
		type = "recipe",
		name = "sand",
		enabled = true,
		categories = { "crafting" },
		ingredients = { { type = "item", name = "stone", amount = 1 } },

		results = { { type = "item", name = "sand", amount = 2 } },
		energy_required = 1,
	},
	{
		type = "recipe",
		name = "monkey-embryon",
		icon = "__planet-of-the-apes__/graphics/icons/Periodic Madness - bacteriaed-petri-dish.png",
		enabled = true,
		categories = { "monkey-breeding" },
		ingredients = {
			{ type = "item", name = "petri-dish", amount = 1 },
		},

		results = { { type = "item", name = "monkey-embryon", amount = 1 } },
		energy_required = 1,
		raise_on_crafted = true,
	},
	{
		type = "recipe",
		name = "monkey-accelerated-growth",
		icon = "__base__/graphics/icons/big-biter.png",
		enabled = true,
		categories = { "monkey-breeding" },
		ingredients = {
			{ type = "item", name = "monkey-embryon", amount = 1 },
			{ type = "item", name = "nutrients", amount = 10 },
		},

		results = { { type = "item", name = "monkey", amount = 1 } },
		--results = {},
		energy_required = 60,
		overload_multiplier = 1,
		maximum_productivity = 0,
		raise_on_crafted = true,
	},

	{
		type = "recipe",
		name = "banana-mash",
		icon = "__space-age__/graphics/icons/yumako-mash.png",
		enabled = true,
		categories = { "organic", "crafting" },
		ingredients = {
			{ type = "item", name = "banana", amount = 1 },
		},

		results = {
			{
				type = "item",
				name = "banana-seed",
				amount = 1,
				independent_probability = 0.02,
			},
			{ type = "item", name = "banana-mash", amount = 2 },
		},
		--results = {},
		energy_required = 1,
		overload_multiplier = 1,
		crafting_machine_tint = {
			primary = { r = 0.976, g = 0.976, b = 0.010, a = 1.000 },
			secondary = { r = 0.805, g = 0.701, b = 0.010, a = 1.000 },
		},
	},
	{
		type = "recipe",
		name = "nutrients-from-banana-mash",
		icon = "__space-age__/graphics/icons/nutrients-from-yumako-mash.png",
		categories = { "organic" },
		auto_recycle = false,
		subgroup = "agriculture-processes",
		enabled = true,
		allow_productivity = true,
		order = "c[nutrients]-d[nutrients-from-yumako-mash]",
		energy_required = 4,
		ingredients = { { type = "item", name = "banana-mash", amount = 4 } },
		results = { { type = "item", name = "nutrients", amount = 6 } },
		crafting_machine_tint = {
			primary = { r = 0.8, g = 0.9, b = 1, a = 1.000 },
			secondary = { r = 0.8, g = 0.2, b = 0.0, a = 1.000 },
		},
	},
})

if not data.raw.recipe["glass"] then
	data:extend({
		{
			type = "recipe",
			name = "glass",
			categories = { "smelting" },
			energy_required = 4,
			ingredients = {
				{ type = "item", name = "sand", amount = 4 },
			},
			results = { { type = "item", name = "glass", amount = 1 } },
			allow_productivity = true,
			enabled = true,
		},
	})
end

data:extend({
	{
		type = "proxy-container",
		name = "my-proxy-container",
	},
})
