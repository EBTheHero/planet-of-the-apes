



function breeder_has_monkeys(breeder_data)
    intentory1 = breeder_data.slot1.get_inventory(defines.inventory.chest)
    inventory2 = breeder_data.slot2.get_inventory(defines.inventory.chest)

    if intentory1.is_empty() or inventory2.is_empty() then
        return false
    else
        return intentory1[1].name == "monkey" and inventory2[1].name == "monkey"
    end

end

function breed(monkey1, monkey2)

    smarts1 = monkey1.get_tag("smarts") or 100
    smarts2 = monkey2.get_tag("smarts") or 100

    -- random range between smarts1 and smarts2
    newSmart = math.random() * (math.max(smarts1, smarts2) - math.min(smarts1, smarts2)) + math.min(smarts1, smarts2)

    -- 10% chance to mutate
    if (math.random() < 0.1) then
        -- range between 0.8 and 1.2
        r = math.random() * 0.4 + 0.8
        newSmart = newSmart * r
    end
    newSmart = math.floor(newSmart)
    statsTags = {smarts = newSmart, creation_time = game.tick}

    return statsTags
end

local test = {}

function test.tick(tick)
    storage.monkey_factories = storage.monkey_factories or {}

    for unit_number, data in pairs(storage.monkey_factories) do
        local entity = data.entity
    
        
        -- entity.disabled_by_script  = not breeder_has_monkeys(data)

        -- on craft
        if entity and entity.valid and data.products_finished < entity.products_finished then
           data.products_finished = entity.products_finished

            outputinventory =entity.get_inventory(defines.inventory.crafter_trash) 

            --stats = breed(data.slot1.get_inventory(defines.inventory.chest)[1], data.slot2.get_inventory(defines.inventory.chest)[1])
            
            -- outputinventory.insert({name = "monkey", count = 1, tags = stats, custom_description = "Born on: " .. game.tick .. " ticks. \nSmarts: " .. stats.smarts})
            outputinventory.insert({name = "ice", count = 1})
            
            -- itemstack = outputinventory[1]

            -- itemstack.tags = stats
            -- itemstack.custom_description = "Born on: " .. game.tick .. " ticks. \nSmarts: " .. stats.smarts
        
            
        
        end
        ::continue::
    end
end

return test