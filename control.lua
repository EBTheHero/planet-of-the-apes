local monkeybreeder = require("scripts.monkey_breeder")
local monkeycombinator = require("scripts.monkey_combinator")
require("scripts.events")

script.on_event(defines.events.on_tick,
  function(e)
    local tick = e.tick
    monkeybreeder.tick(tick)
    monkeycombinator.tick(tick)
  end)

script.on_event(defines.events.on_script_trigger_effect, function(event)

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
            slot1 = slot1,
            slot2 = slot2
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
        breederdata.slot1.destroy{raise_destroy = true}
        breederdata.slot2.destroy{raise_destroy = true}

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
end
)
