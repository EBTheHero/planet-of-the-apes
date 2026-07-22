local monkeybreeder = require("scripts.monkey_breeder")
local monkeycombinator = require("scripts.monkey_combinator")


function freshen_up_monkey(monkey)
    monkey.set_stack({name = "monkey", count = 1, tags = monkey.tags, custom_description = monkey.custom_description})
end

script.on_event(defines.events.on_script_trigger_effect, function(event)
    if (event.effect_id == "rest-dummy-spoil") then
        -- spoil effect in prototypes should only target monkey-chairs
        if (event.target_entity.valid) then
            itemstack = event.target_entity.get_inventory(defines.inventory.chest)[1]
            if (itemstack.valid_for_read and itemstack.name == "tired-monkey") then
                freshen_up_monkey(itemstack)
            end
        end
    end
end)

script.on_event({
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity,
	defines.events.on_space_platform_built_entity,
	defines.events.script_raised_built,
	defines.events.script_raised_revive,
}, function(event)
	local entity = event.entity



    if entity.name == "monkey-breeder" then

        offset = {x = -1, y = 2}
        spawn_position = {entity.position.x + offset.x, entity.position.y + offset.y}
        slot1 = entity.surface.create_entity{name = "monkey-chair", position = spawn_position, force = entity.force, raise_built = true}


        slot1.destructible = false
        slot1.minable_flag = false

        offset = {x = 1, y = 2}
        spawn_position = {entity.position.x + offset.x, entity.position.y + offset.y}
        slot2 = entity.surface.create_entity{name = "monkey-chair", position = spawn_position, force = entity.force, raise_built = true}


        slot2.destructible = false
        slot2.minable_flag = false    

        entity.disabled_by_script  = false


        storage.monkey_factories = storage.monkey_factories or {}

        storage.monkey_factories[entity.unit_number] = {
            entity = entity,
            products_finished = 0,
            slot1 = slot1.get_inventory(defines.inventory.chest)[1],
            slot2 = slot2.get_inventory(defines.inventory.chest)[1],
            chest1 = slot1,
            chest2 = slot2
        }
    end

    if entity.name == "monkey-workstation" then

        beacon = entity.surface.create_entity{name = "monkey-beacon-interface", position = entity.position, force = entity.force, raise_built = true}

        storage.monkey_workstations = storage.monkey_workstations or {}

        offset = {x = 0, y = 2}
        spawn_position = {entity.position.x + offset.x, entity.position.y + offset.y}
        chest1 = entity.surface.create_entity{name = "monkey-chair", position = spawn_position, force = entity.force, raise_built = true}

        chest1.destructible = false
        chest1.minable_flag = false

        storage.monkey_workstations[entity.unit_number] = {
            entity = entity,
            item_stack = chest1.get_inventory(defines.inventory.chest)[1],
            beacon = beacon,
            monkey_chair = chest1,
            previous_read_value = false
        }
    end
    
    if entity.name == "monkey-analyzer" then

        offset = {x = 1, y = 1}
        spawn_position = {entity.position.x + offset.x, entity.position.y + offset.y}
        combinator = entity.surface.create_entity{name = "monkey-analyzer-combinator", position = spawn_position, force = entity.force}
        combinator.operable = false
        storage.monkey_chairs = storage.monkey_chairs or {}

        storage.monkey_chairs[entity.unit_number] = {
            entity = entity,
            combinator = combinator,
            control_behavior_section = combinator.get_or_create_control_behavior().get_section(1),
            -- item_stack = entity.get_inventory(defines.inventory.chest).inventory[1],
            previous_read_value = false,
            canread = entity.get_inventory(defines.inventory.chest)[1].valid_for_read
        }
    end
end
)

script.on_event({
	defines.events.on_player_mined_entity,
	defines.events.on_robot_mined_entity,
	defines.events.on_space_platform_mined_entity,
	defines.events.script_raised_destroy,
  defines.events.on_entity_died,
}, function(event)
	local entity = event.entity

    if entity.name == "monkey-breeder" then
        breederdata = storage.monkey_factories[entity.unit_number]
        breederdata.chest1.destroy{raise_destroy = true}
        breederdata.chest2.destroy{raise_destroy = true}

        storage.monkey_factories[entity.unit_number] = nil
        game.print("Entity mined: " .. entity.name)
    end

    if entity.name == "monkey-analyzer" then
      factorydata = storage.monkey_chairs[entity.unit_number]
      if (factorydata ~= nil) then
          
      
        if (factorydata.combinator and factorydata.combinator.valid) then
            factorydata.combinator.destroy{raise_destroy = true}
        end
      end
      storage.monkey_chairs[entity.unit_number] = nil
      game.print("Entity mined: " .. entity.name)
    end

    if entity.name == "monkey-workstation" then

        workstation_data = storage.monkey_workstations[entity.unit_number]
        if (workstation_data ~= nil) then
            workstation_data.beacon.destroy{raise_destroy = true}
            workstation_data.monkey_chair.destroy{raise_destroy = true}
            storage.monkey_workstations[entity.unit_number] = nil
        end


    end
end
)

script.on_event(
	prototypes.recipe["novella"].on_crafted_event
, function(event)
    machineID = event.entity.unit_number
    workstation_data = storage.monkey_workstations[machineID]
    item_stack = workstation_data.item_stack
    reduce_monkey_health(item_stack, 0.05)
end)

script.on_event(
	prototypes.recipe["monkey-accelerated-growth"].on_crafted_event
, function(event)
        local data = storage.monkey_factories[event.entity.unit_number]
        -- on craft
        if event.entity and event.entity.valid then

            outputinventory = event.entity.get_inventory(defines.inventory.crafter_trash) 
            
            -- stats = breed(data.slot1, data.slot2)
            
            -- outputinventory.insert({name = "monkey-embryon", count = 1, tags = stats, custom_description = make_description_from_stats(stats)})

            -- reduce_monkey_health(data.slot1, 0.05)
            -- reduce_monkey_health(data.slot2, 0.05)

            
        
        end
end)

script.on_event(
	prototypes.recipe["monkey-embryon"].on_crafted_event
, function(event)
        local data = storage.monkey_factories[event.entity.unit_number]
        -- on craft
        if event.entity and event.entity.valid then

            outputinventory = event.entity.get_inventory(defines.inventory.crafter_trash) 
            
            stats = breed(data.slot1, data.slot2)
            
            outputinventory.insert({name = "monkey-embryon", count = 1, tags = stats, custom_description = make_description_from_stats(stats)})

            reduce_monkey_health(data.slot1, 0.05)
            reduce_monkey_health(data.slot2, 0.05)

            
        
        end
end)