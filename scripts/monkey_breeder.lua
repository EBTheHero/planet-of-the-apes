



function breeder_has_monkeys(breeder_data)
    slotonevalid = breeder_data.slot1.valid and breeder_data.slot1.valid_for_read
    slottwovalid = breeder_data.slot2.valid and breeder_data.slot2.valid_for_read

    if slotonevalid and slottwovalid then
        return breeder_data.slot1.name == "monkey" and breeder_data.slot2.name == "monkey"
    else
        return false
    end
end

function breed(monkey1, monkey2)

    if (monkey1.get_tag("smarts") == nil) then
        stats = {smarts = 100, creation_time = game.tick}
        monkey1.tags = stats
        monkey1.custom_description = "Born on: " .. game.tick .. " ticks. \nSmarts: " .. stats.smarts
    end

    if (monkey2.get_tag("smarts") == nil) then
        stats = {smarts = 100, creation_time = game.tick}
        monkey2.tags = stats
        monkey2.custom_description = "Born on: " .. game.tick .. " ticks. \nSmarts: " .. stats.smarts
    end

    smarts1 = monkey1.get_tag("smarts")
    smarts2 = monkey2.get_tag("smarts")

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

function reduce_monkey_health(monkey, health)

    if monkey.valid and monkey.name == "monkey" then
        if monkey.health - health <= 0 then
            -- monkey is spent and becomes tired
            monkey.set_stack({name = "tired-monkey", count = 1, tags = monkey.tags, custom_description = monkey.custom_description})
        else
            monkey.health = monkey.health - 0.05
        end
    end
end

local test = {}

function test.tick(tick)
    storage.monkey_factories = storage.monkey_factories or {}

    for unit_number, data in pairs(storage.monkey_factories) do
        local entity = data.entity
    
        entity.disabled_by_script  = not breeder_has_monkeys(data)

        -- on craft
        if entity and entity.valid and data.products_finished < entity.products_finished then
           data.products_finished = entity.products_finished

            outputinventory =entity.get_inventory(defines.inventory.crafter_trash) 
            
            stats = breed(data.slot1, data.slot2)
            
            outputinventory.insert({name = "monkey", count = 1, tags = stats, custom_description = "Born on: " .. game.tick .. " ticks. \nSmarts: " .. stats.smarts})

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