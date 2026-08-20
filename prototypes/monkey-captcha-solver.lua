local monkey_captcha_solver = {
	type = "assembling-machine",
	name = "monkey-captcha-solver",
	icon_size = 32,
	icon = icon_path .. "monkey-captcha-solver_icon.png",
	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.5, result = "monkey-captcha-solver" },
	max_health = 250,
	corpse = "medium-remnants",
	resistances = {
		{ type = "physical", percent = 20 },
		{ type = "fire", percent = 20 },
	},
	collision_box = { { -0.75, -0.75 }, { 0.75, 0.75 } },
	selection_box = { { -0.9, -0.9 }, { 0.9, 0.9 } },
	---drawing_box = {{-1.5, -1.7}, {1.5, 1.5}},
	fast_replaceable_group = "assembling-machine",

	graphics_set = {
		animation = {
			layers = {
				{
					filename = buildings_path .. "monkey-captcha-solver.png",
					priority = "extra-high",
					scale = 0.5,
					width = 170,
					height = 170,
					shift = { 0.13, 0 },
					frame_count = 16,
					line_length = 4,
					animation_speed = 0.75,
				},
			},
		},
		idle_animation = {
			layers = {
				{
					filename = buildings_path .. "monkey-captcha-solver.png",
					priority = "extra-high",
					scale = 0.5,
					width = 170,
					height = 170,
					shift = { 0.13, 0 },
					frame_count = 16,
					line_length = 4,
					animation_speed = 0.75,
				},
			},
		},

		working_visualisations = {
			{
				light = {
					intensity = 0.5,
					size = 5,
					shift = { 0.0, 0.3 },
					color = { r = 0.1, g = 0.5, b = 1 },
				},
			},
		},
	},

	crafting_categories = { "crafting" },
	fixed_recipe = "iron-gear-wheel",
	vehicle_impact_sound = {
		filename = "__base__/sound/car-metal-impact.ogg",
		volume = 0.65,
	},
	working_sound = {
		sound = {
			{
				filename = sounds_path .. "monkey-captcha-solver.ogg",
				volume = 0.5,
			},
		},
		idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 1 },
		apparent_volume = 1.5,
	},
	crafting_speed = 1,
	energy_source = {
		type = "electric",
		usage_priority = "secondary-input",
		emissions_per_minute = { pollution = 10 },
	},
	energy_usage = "0.2MW",
	ingredient_count = 1,
	module_specification = {},
	allowed_effects = {},
	open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.75 },
	close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
}

data:extend({
	monkey_captcha_solver,
})

local monkey_captcha_solver =
	table.deepcopy(data.raw["item"]["assembling-machine-3"])

monkey_captcha_solver.name = "monkey-captcha-solver"
monkey_captcha_solver.place_result = "monkey-captcha-solver"
monkey_captcha_solver.icon_size = 32

data:extend({
	monkey_captcha_solver,
})

local my_thing_registration = {
	name = "monkey-captcha-solver",
	intercept_construction = true,
	virtualize_orientation = 7, --"d8_R",
	--- @type things.ThingRegistration.Child[]
	children = {
		{
			create = {
				name = "monkey-slot",
				position = { 0, 0 },
				snap_to_grid = false,
			},
			offset = { x = -0, y = 2 },
			lifecycle_type = "void-real",
		},
	},
	custom_events = {
		on_status = "on_status",
		on_initialized = "on_initialized",
	},
}

data.raw["mod-data"]["things-names"].data["monkey-workstation"] =
	my_thing_registration
