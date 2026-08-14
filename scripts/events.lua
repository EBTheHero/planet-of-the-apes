local monkeybreeder = require("scripts.monkey_breeder")
local monkeycombinator = require("scripts.monkey_combinator")

local things_client = require("__0-things__.client.client") --[[@as things.client]]




function freshen_up_monkey(monkey)
    monkey.set_stack({name = "monkey", count = 1, tags = monkey.tags, custom_description = monkey.custom_description})
end

script.on_event(defines.events.on_script_trigger_effect, function(event)
    if (event.effect_id == "rest-dummy-spoil") then
        -- spoil effect in prototypes should only target monkey-slots
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




    if entity.name == "monkey-workstation" then

        storage.monkey_workstations = storage.monkey_workstations or {}

        offset = {x = 0, y = 2}
        spawn_position = {entity.position.x + offset.x, entity.position.y + offset.y}
        chest1 = entity.surface.create_entity{name = "monkey-slot", position = spawn_position, force = entity.force, raise_built = true}

        chest1.destructible = false
        chest1.minable_flag = false

        storage.monkey_workstations[entity.unit_number] = {
            entity = entity,
            item_stack = chest1.get_inventory(defines.inventory.chest)[1],
            monkey_chair = chest1,
            previous_read_value = false
        }
    end
    



    if entity.name == "growth-vat" then


        storage.growth_vats = storage.growth_vats or {}

        storage.growth_vats[entity.unit_number] = {
            entity = entity,
            previous_tick_disabled = true,
            previous_tick_crafting = false,
        }

        entity.disabled_by_script = true

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


    -- if entity.name == "monkey-analyzer" then
    --   factorydata = storage.monkey_analyzer[entity.unit_number]
    --   if (factorydata ~= nil) then
          
      
    --     if (factorydata.combinator and factorydata.combinator.valid) then
    --         factorydata.combinator.destroy{raise_destroy = true}
    --     end
    --   end
    --   storage.monkey_chairs[entity.unit_number] = nil
    --   game.print("Entity mined: " .. entity.name)
    -- end

    if entity.name == "monkey-workstation" then

        workstation_data = storage.monkey_workstations[entity.unit_number]
        if (workstation_data ~= nil) then
            workstation_data.monkey_chair.destroy{raise_destroy = true}
            storage.monkey_workstations[entity.unit_number] = nil
        end
    end

    if entity.name == "growth-vat" then
        growth_vats = storage.growth_vats[entity.unit_number]
        if (growth_vats ~= nil) then
            storage.growth_vats[entity.unit_number] = nil
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
	defines.events.on_tower_planted_seed
, function(event)
    local tower = event.tower
    local itemstack = tower.get_inventory(defines.inventory.agricultural_tower_input)[1]
    game.print("plant")
end)

script.on_event(
	prototypes.recipe["monkey-accelerated-growth"].on_crafted_event
, function(event)
        local data = storage.growth_vats[event.entity.unit_number]
        -- on craft
        if event.entity and event.entity.valid then

            local stats = data.consumed_embryon_tags
            local outputinventory = event.entity.get_inventory(defines.inventory.crafter_output) 
            
            -- stats = breed(data.slot1, data.slot2)
            
            outputinventory[1].tags = stats
            outputinventory[1].custom_description = make_description_from_stats(stats)

            local input_stack = event.entity.get_inventory(defines.inventory.crafter_input)[1]
            
            if (input_stack.valid_for_read and input_stack.name == "monkey-embryon") then
               -- As it finishes, we need to store the new consumed embryon
                data.consumed_embryon_tags = input_stack.tags
            end

            -- reduce_monkey_health(data.slot1, 0.05)
            -- reduce_monkey_health(data.slot2, 0.05)

            
        
        end
end)

script.on_event(
	prototypes.recipe["monkey-embryon"].on_crafted_event
, function(event)
        local thing_id = things_client.get_thing_id(event.entity)
        local data = storage.monkey_breeders[thing_id]
        -- on craft
        if event.entity and event.entity.valid then

            outputinventory = event.entity.get_inventory(defines.inventory.crafter_output) 
            
            stats = breed(data.slot1, data.slot2)
            
            if (stats == nil) then
                return
            end

            stats.name = get_name()

            outputinventory[1].tags = stats
            outputinventory[1].custom_description = make_description_from_stats(stats)

            reduce_monkey_health(data.slot1, 0.05)
            reduce_monkey_health(data.slot2, 0.05)

            
        
        end
end)

-- --- @param event things.EventData.on_child_status
-- script.on_event(
--   "on_child_status",
  
--   function(eventdata)
--     local parent = eventdata.thing
--     --- @type things.ThingShortSummary
--     local child = eventdata.child
    
--     if (child.status == "real") then
--         things_client.tags_v1.set_tag(parent[1], "control_behavior_section", child.get_or_create_control_behavior().get_section(1))
--     end


--   end
-- )

--- @param thing things.ThingShortSummary
function became_real(thing)

    if (thing.thing_name == "monkey-analyzer-combinator") then
        local parent = thing.parent
        storage.monkey_analyzers[parent[1]].control_behavior_section = thing.entity.get_or_create_control_behavior().get_section(1)
    end

    if thing.thing_name == "monkey-analyzer" then

        storage.monkey_analyzers = storage.monkey_analyzers or {}

        local fullthing = things_client.get(thing.id)
        storage.monkey_analyzers[thing.id] = {
        thing = fullthing,
        item_stack = thing.entity.get_inventory(defines.inventory.chest)[1],
        previous_read_value = thing.entity.get_inventory(defines.inventory.chest)[1].valid_for_read
        }
    end

    if thing.thing_name == "monkey-breeder" then

        storage.monkey_breeders = storage.monkey_breeders or {}

        storage.monkey_breeders[thing.id] = {
            entity = thing.entity
        }
    end

    if thing.thing_name == "monkey-slot" then

        local parent = thing.parent
        -- add the monkey-slot to the parent monkey-breeder's storage array
        local stack = thing.entity.get_inventory(defines.inventory.chest)[1]
        
        if not storage.monkey_breeders[parent[1]].slot1 then
            storage.monkey_breeders[parent[1]].slot1 = stack
        elseif not storage.monkey_breeders[parent[1]].slot2 then
            storage.monkey_breeders[parent[1]].slot2 = stack
        end

        thing.entity.destructible = false
        thing.entity.minable_flag = false

    end
end

function became_void(thing)
    if (thing.name == "monkey-analyzer") then
        storage.monkey_analyzers[thing.id] = nil
    end

    if (thing.name == "monkey-breeder") then
        storage.monkey_breeders[thing.id] = nil
    end
end

script.on_event(
    "on_status",
    --- @param event things.EventData.on_status
  function(eventdata)
    --- @type things.ThingShortSummary
    local thing = eventdata.thing
    
    if (thing.status == "real") then
        became_real(thing)
    end

    if (thing.status == "void") then
        became_void(thing)
    end

  end
)

script.on_event(
  "on_initialized",
--- @param event things.EventData.on_initialized
  function(eventdata)
    --- @type things.ThingShortSummary
    local thing = eventdata
    

  if (eventdata.status == "real") then
      became_real(eventdata)
    end

  end
)

