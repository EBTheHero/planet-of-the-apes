local workstation = {}



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
                    data.entity.local_effect = {quality = creativity / 100, productivity = meticulousness / 100, consumption = endurance, speed = 0, pollution = 0}
                else
                    data.entity.local_effect = {quality = 0, productivity = 0, consumption = 0, speed = 0, pollution = 0}
                end
            else
                data.entity.local_effect = {quality = 0, productivity = 0, consumption = 0, speed = 0, pollution = 0}
            end
        end
    end
end

return workstation