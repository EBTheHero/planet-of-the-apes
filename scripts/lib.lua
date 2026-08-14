

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
    return "Name: " .. stats.name .. " \nSmarts: " .. stats.smarts .. "\nMeticulousness: " .. stats.meticulousness .. "\nCreativity: " .. stats.creativity .. "\nEndurance: " .. stats.endurance
    
end

function verify_monkey(itemstack)

    if (not itemstack.valid_for_read) then
        return false
    end

    
    if (itemstack.get_tag("smarts") == nil) then
        stats = {name = get_name(), smarts = 120, meticulousness = 10, creativity = 30, endurance = 50, creation_time = game.tick}
        itemstack.tags = stats
        itemstack.custom_description = make_description_from_stats(stats)
    end
    return true
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


local names = {
	"Max",
	"Buddy",
	"Charlie",
	"Jack",
	"Cooper",
	"Rocky",
	"Toby",
	"Tucker",
	"Jake",
	"Bear",
	"Duke",
	"Teddy",
	"Oliver",
	"Riley",
	"Bailey",
	"Bentley",
	"Milo",
	"Buster",
	"Cody",
	"Dexter",
	"Winston",
	"Murphy",
	"Leo",
	"Lucky",
	"Oscar",
	"Louie",
	"Zeus",
	"Henry",
	"Sam",
	"Harley",
	"Baxter",
	"Gus",
	"Sammy",
	"Jackson",
	"Bruno",
	"Diesel",
	"Jax",
	"Gizmo",
	"Bandit",
	"Rusty",
	"Marley",
	"Jasper",
	"Brody",
	"Roscoe",
	"Hank",
	"Otis",
	"Bo",
	"Joey",
	"Beau",
	"Ollie",
	"Tank",
	"Shadow",
	"Peanut",
	"Hunter",
	"Scout",
	"Blue",
	"Rocco",
	"Simba",
	"Tyson",
	"Ziggy",
	"Boomer",
	"Romeo",
	"Apollo",
	"Ace",
	"Luke",
	"Rex",
	"Finn",
	"Chance",
	"Rudy",
	"Loki",
	"Moose",
	"George",
	"Samson",
	"Coco",
	"Benny",
	"Thor",
	"Rufus",
	"Prince",
	"Chester",
	"Brutus",
	"Scooter",
	"Chico",
	"Spike",
	"Gunner",
	"Sparky",
	"Mickey",
	"Kobe",
	"Chase",
	"Oreo",
	"Frankie",
	"Mac",
	"Benji",
	"Bubba",
	"Champ",
	"Brady",
	"Elvis",
	"Copper",
	"Cash",
	"Archie",
	"Walter",
	"Bella",
	"Lucy",
	"Daisy",
	"Molly",
	"Lola",
	"Sophie",
	"Sadie",
	"Maggie",
	"Chloe",
	"Bailey",
	"Roxy",
	"Zoey",
	"Lily",
	"Luna",
	"Coco",
	"Stella",
	"Gracie",
	"Abby",
	"Penny",
	"Zoe",
	"Ginger",
	"Ruby",
	"Rosie",
	"Lilly",
	"Ellie",
	"Mia",
	"Sasha",
	"Lulu",
	"Pepper",
	"Nala",
	"Lexi",
	"Lady",
	"Emma",
	"Riley",
	"Dixie",
	"Annie",
	"Maddie",
	"Piper",
	"Princess",
	"Izzy",
	"Maya",
	"Olive",
	"Cookie",
	"Roxie",
	"Angel",
	"Belle",
	"Layla",
	"Missy",
	"Cali",
	"Honey",
	"Millie",
	"Harley",
	"Marley",
	"Holly",
	"Kona",
	"Shelby",
	"Jasmine",
	"Ella",
	"Charlie",
	"Minnie",
	"Willow",
	"Phoebe",
	"Callie",
	"Scout",
	"Katie",
	"Dakota",
	"Sugar",
	"Sandy",
	"Josie",
	"Macy",
	"Trixie",
	"Winnie",
	"Peanut",
	"Mimi",
	"Hazel",
	"Mocha",
	"Cleo",
	"Hannah",
	"Athena",
	"Lacey",
	"Sassy",
	"Lucky",
	"Bonnie",
	"Allie",
	"Brandy",
	"Sydney",
	"Casey",
	"Gigi",
	"Baby",
	"Madison",
	"Heidi",
	"Sally",
	"Shadow",
	"Cocoa",
	"Pebbles",
	"Misty",
	"Nikki",
	"Lexie",
	"Grace",
	"Sierra"
}

function get_name() 
    return names[math.random(1, #names)]
end

