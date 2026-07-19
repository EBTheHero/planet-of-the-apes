local monkey_breeder = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"]);

monkey_breeder.name = "monkey-breeder"

monkey_breeder.crafting_categories = {"monkey-breeding"}

data:extend({
    monkey_breeder,
});