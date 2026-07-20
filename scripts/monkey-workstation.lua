local workstation = {}

function workstation.tick(tick)
    storage.monkey_workstations = storage.monkey_workstations or {}

    for unit_number, data in pairs(storage.monkey_workstations) do

        stack = data.item_stack



        v = stack.valid_for_read
        if (v ~= data.previous_read_value) then
            -- item changed, update the control behavior section
            data.previous_read_value = stack.valid_for_read

            if (stack.valid_for_read) then
                if (stack.name == "monkey") then
                    smarts = stack.get_tag("smarts")
                    remote.call("beacon-interface", "set_effect", data.beacon.unit_number, "quality", smarts)
                else
                    remote.call("beacon-interface", "set_effect", data.beacon.unit_number, "quality", 0)
                end
            else
                remote.call("beacon-interface", "set_effect", data.beacon.unit_number, "quality", 0)
            end
        end
    end
end

return workstation