

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

function make_description_from_stats(stats)
    return "Born on: " .. game.tick .. " ticks. \nSmarts: " .. stats.smarts .. "\nMeticulousness: " .. stats.meticulousness .. "\nCreativity: " .. stats.creativity .. "\nEndurance: " .. stats.endurance
    
end

function verify_monkey(itemstack)

    if (itemstack.get_tag("smarts") == nil) then
        stats = {smarts = 100, meticulousness = 100, creativity = 100, endurance = 50, creation_time = game.tick}
        itemstack.tags = stats
        itemstack.custom_description = make_description_from_stats(stats)
    end
end