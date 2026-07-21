

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

function get_bits(number)
  local bits = {}
  for i = 0, 15 do
      bits[i + 1] = bit32.band(number, bit32.lshift(1, i)) ~= 0 and 1 or 0
  end
  return bits
end

function breeder_has_monkeys(breeder_data)
    slotonevalid = breeder_data.slot1.valid and breeder_data.slot1.valid_for_read
    slottwovalid = breeder_data.slot2.valid and breeder_data.slot2.valid_for_read

    if slotonevalid and slottwovalid then
        return breeder_data.slot1.name == "monkey" and breeder_data.slot2.name == "monkey"
    else
        return false
    end
end

function itemstack_is_monkey(itemstack)
    if itemstack.valid and itemstack.valid_for_read then
        return itemstack.name == "monkey"
    else
        return false
    end
end