require 'scenes.game'

function love.load()
   love.graphics.setBackgroundColor(0.1, 0.3, 1)

   currentScene = 1
   winW, winH = love.graphics.getDimensions()

   mouseP = false

   mouseX, mouseY = love.mouse.getPosition()

   love.physics.setMeter(64)
   world = love.physics.newWorld(0, 0)
      world:setCallbacks(beginContact, endContact, preSolve, postSolve)

   scenes = {}
   table.insert(scenes, gameS)

   scenes[currentScene]:load()
end

function love.update(dt)
   world:update(dt)
   scenes[currentScene]:update()
end

function love.draw()
   scenes[currentScene]:draw()
end

-- World Collision Callbacks
function beginContact(x, y, coll)
   local a, b = x, y
   if currentScene == 1 then
      scenes[currentScene]:beginContact(a, b)
   end
end

function endContact(a, b, coll)
   -- nothing for now
end

function preSolve(x, y, coll)
   local a, b = x, y
   if currentScene == 1 then
      scenes[currentScene]:preSolve(a, b)
   end
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
   -- nothing for now
end