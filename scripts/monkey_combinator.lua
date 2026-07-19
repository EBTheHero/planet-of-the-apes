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
                    data.control_behavior_section.set_slot(1, {value = "signal-C", min = stack.get_tag("smarts")})
                end
            else
                data.control_behavior_section.clear_slot(1)
            end
        end
    end
end

return combinator