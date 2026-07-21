local workstation = {}

function refresh_effects(entity, effects)

  inventory = entity.get_inventory(defines.inventory.crafter_modules)
  inventory.clear()
  for effect, value in pairs(effects) do
    if 0 > value then
      inventory.insert({name = string.format("beacon-interface--" .. "%s-module-16", effect)})
    end
    local bits = get_bits(value)
    for i, bit in ipairs(bits) do
      if bit == 1 then
        local two_character_number = string.format("%02d", i)
        local module_name = string.format("beacon-interface--" .. "%s-module-%s", effect, two_character_number)
        assert(inventory.insert({name = module_name}), module_name)
      end
    end
  end
end

function workstation.tick(tick)
    storage.monkey_workstations = storage.monkey_workstations or {}

    for unit_number, data in pairs(storage.monkey_workstations) do

        stack = data.item_stack

        data.entity.disabled_by_script  = not itemstack_is_monkey(stack)

        v = stack.valid_for_read
        if (v ~= data.previous_read_value) then
            -- item changed, update the control behavior section
            data.previous_read_value = stack.valid_for_read

            if (stack.valid_for_read) then
                if (stack.name == "monkey") then
                    creativity = stack.get_tag("creativity")
                    meticulousness = stack.get_tag("meticulousness")
                    endurance = stack.get_tag("endurance")
                    remote.call("beacon-interface", "set_effects", data.beacon.unit_number, {quality = creativity, productivity = meticulousness, consumption = endurance, speed = 0, pollution = 0})
                else
                    remote.call("beacon-interface", "set_effects", data.beacon.unit_number, {quality = 0, productivity = 0, consumption = 0, speed = 0, pollution = 0})
                
                end
            else
                remote.call("beacon-interface", "set_effect", data.beacon.unit_number, "quality", 0)
            end
        end
    end
end

return workstation