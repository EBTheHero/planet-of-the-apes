local monkeybreeder = require("scripts.monkey_breeder")
local monkeycombinator = require("scripts.monkey_combinator")

-- All the on tick events are handled here.
script.on_event(defines.events.on_tick,
  function(e)
    local tick = e.tick
    monkeybreeder.tick(tick)
    monkeycombinator.tick(tick)
  end)
  
require("scripts.events")
