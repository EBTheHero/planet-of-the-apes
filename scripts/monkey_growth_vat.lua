local test = {}

function test.get_is_crafting(entity) return entity.is_crafting() end

function test.set_disabled(entity, y, z)
	if test.get_disabled(entity) ~= (y or z) then
		entity.disabled_by_script = y or z
	end
	return y or z
end

function test.get_disabled(entity) return entity.disabled_by_script end

-- TODO: Optimise
function test.tick(tick)
	storage.growth_vats = storage.growth_vats or {}

	for unit_number, data in pairs(storage.growth_vats) do
		local entity = data.entity

		-- don't check recipe, as it's recipe locked
		if true then
			if data.input_stack == nil then
				data.input_stack =
					entity.get_inventory(defines.inventory.crafter_input)[1]
			end
			local x = data.input_stack
			local y = x.valid_for_read
			local z = test.get_is_crafting(entity)

			local disabled = not y and not z
			entity.disabled_by_script = disabled

			if not disabled and data.previous_tick_disabled then
				-- Entity just got a new embryon and will start crafting. Store it for later.
				data.consumed_embryon_tags = data.input_stack.tags
			end

			data.previous_tick_disabled = disabled
		end
	end
end

return test
