local function applyTint(proto,tint)
  for _,p in pairs(proto.pictures) do
    --if p.ties then
    --  p.ties.tint = tint
    --  if p.ties.hr_version then
    --    p.ties.hr_version.tint = tint
    --  end
    --end
    if p.stone_path then
      p.stone_path.tint = tint
      if p.stone_path.hr_version then
        p.stone_path.hr_version.tint = tint
      end
    end
    if p.stone_path_background then
      p.stone_path_background.tint = tint
      if p.stone_path_background.hr_version then
        p.stone_path_background.hr_version.tint = tint
      end
    end
  end
end


local lsrail = table.deepcopy(data.raw['straight-rail']['straight-rail'])
lsrail.name = "local-straight-rail"
lsrail.minable.result = "local-rail"
lsrail.path_cost_multiplier = settings['local-rail-multiplier']
applyTint(lsrail,{r=0.8,g=0.8,b=0.2})

local lcrail = table.deepcopy(data.raw['curved-rail']['curved-rail'])
lcrail.name = "local-curved-rail"
lcrail.minable.result = "local-rail"
lcrail.placeable_by.item = "local-rail"
lcrail.path_cost_multiplier = settings['local-rail-multiplier']
applyTint(lcrail,{r=0.8,g=0.8,b=0.2})

local esrail = table.deepcopy(data.raw['straight-rail']['straight-rail'])
esrail.name = "express-straight-rail"
esrail.minable.result = "express-rail"
esrail.path_cost_multiplier = settings['express-rail-multiplier']
applyTint(esrail,{r=0.6,g=0.6,b=1})

local ecrail = table.deepcopy(data.raw['curved-rail']['curved-rail'])
ecrail.name = "express-curved-rail"
ecrail.minable.result = "express-rail"
ecrail.placeable_by.item = "express-rail"
ecrail.path_cost_multiplier = settings['express-rail-multiplier']
applyTint(ecrail,{r=0.6,g=0.6,b=1})

local erail = table.deepcopy(data.raw['rail-planner']['rail'])
erail.name = "express-rail"
erail.icons = {
  {icon = erail.icon, tint = {r=0.6,g=0.6,b=1}}
}
erail.icon = nil
erail.localised_name = {"item-name.express-rail"}
erail.place_result = "express-straight-rail"
erail.straight_rail = "express-straight-rail"
erail.curved_rail = "express-curved-rail"
erail.order = "a[train-system]-b[rail]"

local lrail = table.deepcopy(data.raw['rail-planner']['rail'])
lrail.name = "local-rail"
lrail.icons = {
  {icon = lrail.icon, tint = {r=0.8,g=0.8,b=0.2}}
}
lrail.icon = nil
lrail.localised_name = {"item-name.local-rail"}
lrail.place_result = "local-straight-rail"
lrail.straight_rail = "local-straight-rail"
lrail.curved_rail = "local-curved-rail"
lrail.order = "a[train-system]-5[rail]"

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
  {
    type = "technology",
    name = "railway-2",
    icon_size = 128,
    icon = "__base__/graphics/technology/railway.png",
    effects =
    {
      {type = "unlock-recipe", recipe = "local-rail"},
      {type = "unlock-recipe", recipe = "express-rail"},
    },
    prerequisites = {"rail-signals"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "c-g-d"
  },
}
