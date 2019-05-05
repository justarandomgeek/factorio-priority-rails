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


local function makeRailClass(prefix,multiplier,tint)

  local srail = table.deepcopy(data.raw['straight-rail']['straight-rail'])
  srail.name = prefix .. "-straight-rail"
  srail.minable.result = prefix .. "-rail"
  srail.path_cost_multiplier = multiplier
  applyTint(srail,tint)

  local crail = table.deepcopy(data.raw['curved-rail']['curved-rail'])
  crail.name = prefix .. "-curved-rail"
  crail.minable.result = prefix .. "-rail"
  crail.placeable_by.item = prefix .. "-rail"
  crail.path_cost_multiplier = multiplier
  applyTint(crail,tint)

  local rail = table.deepcopy(data.raw['rail-planner']['rail'])
  rail.name = prefix .. "-rail"
  rail.icons = {
    {icon = rail.icon, tint = tint}
  }
  rail.icon = nil
  rail.localised_name = {"item-name." .. prefix .. "-rail"}
  rail.place_result = prefix .. "-straight-rail"
  rail.straight_rail = prefix .. "-straight-rail"
  rail.curved_rail = prefix .. "-curved-rail"
  rail.order = "a[train-system]-a[rail]"

  data:extend{
    srail,
    crail,
    rail,
    {
      type = "recipe",
      name = prefix .. "-rail",
      enabled = false,
      ingredients =
      {
        {"rail", 1},
      },
      result = prefix .. "-rail",
    },
  }
end

makeRailClass("local", settings['startup']['local-rail-multiplier'].value, {r=0.8,g=0.8,b=0.2})
makeRailClass("express", settings['startup']['express-rail-multiplier'].value, {r=0.6,g=0.6,b=1})

data:extend{
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
