for _,force in pairs(game.forces) do
  force.recipes["local-rail"].enabled =  force.technologies["railway-2"].researched
  force.recipes["express-rail"].enabled =  force.technologies["railway-2"].researched
end
