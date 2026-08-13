local combinator = {}

function combinator.tick(tick)
    storage.monkey_analyzers = storage.monkey_analyzers or {}

    for thing, data in pairs(storage.monkey_analyzers) do

        local t = things_client.get(thing)
        local tags = t.tags
        local control_behavior_section = tags["control_behavior_section"]
        local stack = tags["item_stack"]
        local previous_read_value = tags["previous_read_value"]

        if (control_behavior_section == nil) then
            return
        end

        v = stack.valid_for_read
        if (v ~= previous_read_value) then
            -- item changed, update the control behavior section
            previous_read_value = stack.valid_for_read
            things_client.tags_v1.set_tag(thing_id, "previous_read_value", previous_read_value)
            if (stack.valid_for_read) then
                if (stack.name == "monkey" or stack.name == "tired-monkey") then
                    stats = stack.tags

                    control_behavior_section.set_slot(1, {value = "signal-C", min = stats["creativity"]})
                    control_behavior_section.set_slot(2, {value = "signal-S", min = stats["smarts"]})
                    control_behavior_section.set_slot(3, {value = "signal-M", min = stats["meticulousness"]})
                    control_behavior_section.set_slot(4, {value = "signal-E", min = stats["endurance"]})
                end
            else
                control_behavior_section.clear_slot(1)
                control_behavior_section.clear_slot(2)
                control_behavior_section.clear_slot(3)
                control_behavior_section.clear_slot(4)
            end
        end
    end
end

return combinator