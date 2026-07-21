local combinator = {}

function combinator.tick(tick)
    storage.monkey_chairs = storage.monkey_chairs or {}

    for unit_number, data in pairs(storage.monkey_chairs) do

        stack = data.item_stack
        if (stack == nil) then
            data.item_stack = data.entity.get_inventory(defines.inventory.chest)[1]
            data.inventory = data.entity.get_inventory(defines.inventory.chest)
            data.previous_read_value = false
            stack = data.item_stack
        end


        v = stack.valid_for_read
        if (v ~= data.previous_read_value) then
            -- item changed, update the control behavior section
            data.previous_read_value = stack.valid_for_read

            if (stack.valid_for_read) then
                if (stack.name == "monkey" or stack.name == "tired-monkey") then
                    stats = stack.tags

                    data.control_behavior_section.set_slot(1, {value = "signal-C", min = stats["creativity"]})
                    data.control_behavior_section.set_slot(2, {value = "signal-S", min = stats["smarts"]})
                    data.control_behavior_section.set_slot(3, {value = "signal-M", min = stats["meticulousness"]})
                    data.control_behavior_section.set_slot(4, {value = "signal-E", min = stats["endurance"]})
                end
            else
                data.control_behavior_section.clear_slot(1)
                data.control_behavior_section.clear_slot(2)
                data.control_behavior_section.clear_slot(3)
                data.control_behavior_section.clear_slot(4)
            end
        end
    end
end

return combinator