Monkeys can get tired and need rest and feeding
- Monkeys have durability that decreases for every amount of work
    - Bad idea, as Brawn monkeys, that work with speed, will exhaust faster
- OR monkeys can spoil. Must find a way that they can spoil without loosing tags
Monkeys need to rest inside a building
- Can the building be biome locked, encouranging players to make trains that carry monkeys?
- Monkeys have a chance of dying of old age when resting
- resting could be done with one structure with a recipe with no ingredient, and the result is an item with instant spoil, and it's trigger affects all monkey-slots around 
- The resting shouldn't be instant. It should have a chance to heal the monkey
- That one structure is a world tree. It takes in bananas and produces random particles that has a chance to hit monkey-slots

Food is from agricultural towers

Three monkey stats, with each offering a puzzle
Monkey's creativity' increases QUALITY of work
- Final recipes require ingredient of specific quality
- A Monkey with 0 creativity produces no quality work
- A monkey with 1 creativity offers a +100% quality bonus, producing uncommon work

Monkey's Minutia increases productivity
- Maybe have a recipe with cataclyst?
- Makes products required for creative work
- take ingredients from Brawn work
- Since ingredients from Brawn work is hard to get, productivity is encouraged
- MIND THE 300% PRODUCTIVITY LIMIT (or check EffectReceiver.productivity_limits and REcipePrototype.maximum_productivity)

Monkey's Brawn increases speed of work
- They work in fixed mines (like oil wells)
- These mines have infinite resources, but do not benifit from mining productivity
- Since it takes effort to place more mines (and trains), encourages the player to breed faster monkeys

Monkey's Smarts
- Solving Captchas lmao
- Solving Captchas require power (USB stick with Captchas)
- Science pack requires a lot of solved Captchas
- A smart monkey increases it's solving speed (thus producing more captchas with less power)
- The machine to produce Captchas require a ton of power

Each stats represent a specific work

Monkey death
- TODO: make monkeys not recyclable
- Monkeys have a chance of dying at work (or have age)
- Monkeys can be intentionally killed in a slaughter house, using ammo as a resource
- Monkey turn into corpses (cannot stack nor recycled)
- Monkey can be cremated (produces pollution) that can be turned to ash. It takes oil/gas
    - How do I discourage players from making a sea of steel chests?
        - Steel chests is not automation
        - Monkeys are not stackable, so they should fill the 48 slots of a steel chest fast
        - If they breed a ton of monkeys (which is the intention), those chests should fill fast
- Ash can be recycled

Production:
- Paper: Wood needs to be turned into pulp then into paper
- Steam clouds to be harvested and turned into water
- Power byproduct (like Steam)

Pollution
- Pollution makes sick monkeys
- Monkey work does not create pollution

Rewards
- Something that helps with spoilables
- What could a monkey on a space platform do? Control it's speed?
- One of the buildings should be useful somewhere off the planet
- An infinite tech?


Other:
There's a "moshine - datacell-empty.png" that's a usb stick and I want a recipe that has a 50% chance of failure caus of it
Monkeys have gender/sex. You can only breed male with females (that's only a reason to add transgenderism)



TODO:
- Have the monkey analyzer have a EntityPrototype.stateless_visualisation to animate it
- place hide-alt-info onto stuff

Modding notes:
Recipes that transfer tags from ingredient to product item-with-tags will [not be implemented ](https://forums.factorio.com/viewtopic.php?p=644838&hilit=Tags#p644838)
If too many crafting machine checks, use Factorio standard lib spread-across-ticks
Use Things for the analyzer

For compound entities: When blueprinting an entity that is unaccessible to the player, like a combinator, having it be neutral will not have an annoying building notification in the corner


Graphics:
https://github.com/malcolmriley/unused-renders for icons
https://github.com/nicholasgower/hurricane-graphics for buildings
Scpace exploration and krastorio too