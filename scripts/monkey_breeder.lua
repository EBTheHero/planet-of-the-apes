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

    local valid1 = verify_monkey(monkey1)
    local valid2 = verify_monkey(monkey2)

    if (not valid1 or not valid2) then
        return
    end

    local smarts1 = monkey1.get_tag("smarts")
    local smarts2 = monkey2.get_tag("smarts")
    local newSmart = breed_two_stats(smarts1, smarts2)

    local meticulousness1 = monkey1.get_tag("meticulousness")
    local meticulousness2 = monkey2.get_tag("meticulousness")
    local newMeticulousness = breed_two_stats(meticulousness1, meticulousness2)

    local creativity1 = monkey1.get_tag("creativity")
    local creativity2 = monkey2.get_tag("creativity")
    local newCreativity = breed_two_stats(creativity1, creativity2)

    local endurance1 = monkey1.get_tag("endurance")
    local endurance2 = monkey2.get_tag("endurance")
    local newEndurance = breed_two_stats(endurance1, endurance2)

    local statsTags = {smarts = newSmart, meticulousness = newMeticulousness, creativity = newCreativity, endurance = newEndurance, creation_time = game.tick, id = math.random(0, 100000000)}

    return statsTags
end



local test = {}

function test.tick(tick)
    storage.monkey_breeders = storage.monkey_breeders or {}

    for unit_number, data in pairs(storage.monkey_breeders) do
        local entity = data.entity
    
        entity.disabled_by_script  = not breeder_has_monkeys(data)
    end
end

return test