local monkeybreeder = require("scripts.monkey_breeder")
local monkeycombinator = require("scripts.monkey_combinator")
local monkeyworkstation = require("scripts.monkey-workstation")

-- All the on tick events are handled here.
script.on_event(defines.events.on_tick,
  function(e)
    local tick = e.tick
    monkeybreeder.tick(tick)
    monkeycombinator.tick(tick)
    monkeyworkstation.tick(tick)
  end)

require("scripts.events")
