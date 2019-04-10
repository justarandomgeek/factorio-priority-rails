local lsrail = table.deepcopy(data.raw['straight-rail']['straight-rail'])
lsrail.name = "local-straight-rail"
lsrail.minable.result = "local-rail"
lsrail.path_cost_multiplier = settings['local-rail-multiplier']

local lcrail = table.deepcopy(data.raw['curved-rail']['curved-rail'])
lcrail.name = "local-curved-rail"
lcrail.minable.result = "local-rail"
lcrail.path_cost_multiplier = settings['local-rail-multiplier']

local esrail = table.deepcopy(data.raw['straight-rail']['straight-rail'])
esrail.name = "express-straight-rail"
esrail.minable.result = "express-rail"
esrail.path_cost_multiplier = settings['express-rail-multiplier']

local ecrail = table.deepcopy(data.raw['curved-rail']['curved-rail'])
ecrail.name = "express-curved-rail"
ecrail.minable.result = "express-rail"
ecrail.path_cost_multiplier = settings['express-rail-multiplier']

local erail = table.deepcopy(data.raw['rail-planner']['rail'])
erail.name = "express-rail"
erail.localised_name = {"item-name.express-rail"}
erail.place_result = "express-straight-rail"
erail.straight_rail = "express-straight-rail"
erail.curved_rail = "express-curved-rail"
erail.order = "a[train-system]-a[rail]-e"

local lrail = table.deepcopy(data.raw['rail-planner']['rail'])
lrail.name = "local-rail"
lrail.localised_name = {"item-name.local-rail"}
lrail.place_result = "local-straight-rail"
lrail.straight_rail = "local-straight-rail"
lrail.curved_rail = "local-curved-rail"
lrail.order = "a[train-system]-a[rail]-l"


table.insert( data.raw["technology"]["railway"].effects, {type = "unlock-recipe", recipe = "local-rail"})
table.insert( data.raw["technology"]["railway"].effects, {type = "unlock-recipe", recipe = "express-rail"})

data:extend{
  lsrail,
  esrail,
  lcrail,
  ecrail,
  erail,
  lrail,
  {
   type = "recipe",
   name = "local-rail",
   enabled = false,
   ingredients =
   {
     {"rail", 1},
   },
   result = "local-rail",
 },
 {
  type = "recipe",
  name = "express-rail",
  enabled = false,
  ingredients =
  {
    {"rail", 1},
  },
  result = "express-rail",
},
}
