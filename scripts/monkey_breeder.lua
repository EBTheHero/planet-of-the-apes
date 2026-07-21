require("scripts.lib")





function breed_two_stats(n1, n2)
    n3 = math.random() * (math.max(n1, n2) - math.min(n1, n2)) + math.min(n1, n2)

    -- 10% chance to mutate
    if (math.random() < 0.1) then
        -- range between -10 and +10
        r = math.random() * 20 - 10
        n3 = n3 + r
    end
    n3 = math.floor(n3)
    return n3
end

function breed(monkey1, monkey2)

    verify_monkey(monkey1)
    verify_monkey(monkey2)

    smarts1 = monkey1.get_tag("smarts")
    smarts2 = monkey2.get_tag("smarts")
    newSmart = breed_two_stats(smarts1, smarts2)

    meticulousness1 = monkey1.get_tag("meticulousness")
    meticulousness2 = monkey2.get_tag("meticulousness")
    newMeticulousness = breed_two_stats(meticulousness1, meticulousness2)

    creativity1 = monkey1.get_tag("creativity")
    creativity2 = monkey2.get_tag("creativity")
    newCreativity = breed_two_stats(creativity1, creativity2)

    endurance1 = monkey1.get_tag("endurance")
    endurance2 = monkey2.get_tag("endurance")
    newEndurance = breed_two_stats(endurance1, endurance2)

    statsTags = {smarts = newSmart, meticulousness = newMeticulousness, creativity = newCreativity, endurance = newEndurance, creation_time = game.tick}

    return statsTags
end



local test = {}

function test.tick(tick)
    storage.monkey_factories = storage.monkey_factories or {}

    for unit_number, data in pairs(storage.monkey_factories) do
        local entity = data.entity
    
        entity.disabled_by_script  = not breeder_has_monkeys(data)

        -- on craft
        if entity and entity.valid and data.products_finished < entity.products_finished and not entity.disabled_by_script then
           data.products_finished = entity.products_finished

            outputinventory =entity.get_inventory(defines.inventory.crafter_trash) 
            
            stats = breed(data.slot1, data.slot2)
            
            outputinventory.insert({name = "monkey", count = 1, tags = stats, custom_description = make_description_from_stats(stats)})

            reduce_monkey_health(data.slot1, 0.05)
            reduce_monkey_health(data.slot2, 0.05)
            -- itemstack = outputinventory[1]

            -- itemstack.tags = stats
            -- itemstack.custom_description = "Born on: " .. game.tick .. " ticks. \nSmarts: " .. stats.smarts
        
            
        
        end
        ::continue::
    end
end

return test