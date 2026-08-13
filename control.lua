local monkeybreeder = require("scripts.monkey_breeder")
local monkeycombinator = require("scripts.monkey_combinator")
local monkeyworkstation = require("scripts.monkey_workstation")
local growth_vat = require("scripts.monkey_growth_vat")

---@diagnostic disable-next-line: unresolved-require
things_client = require("__0-things__.client.client") --[[@as things.client]]

-- All the on tick events are handled here.
script.on_event(defines.events.on_tick,
  function(e)
    local tick = e.tick
    monkeybreeder.tick(tick)
    monkeycombinator.tick(tick)
    monkeyworkstation.tick(tick)
    growth_vat.tick(tick)
  end)



require("scripts.events")
