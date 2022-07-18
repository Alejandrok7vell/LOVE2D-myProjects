function love.load()
   winW, winH = love.graphics.getDimensions()
   mouseX, mouseY = love.mouse:getPosition()
   scenes = {}
   currentScene = 1
   table.insert(scenes, require('scenes.game'))
   scenes[currentScene].load()
end

function love.update(dt)
   mouseX, mouseY = love.mouse:getPosition()
   scenes[currentScene].update(dt)
end

function love.draw()
   scenes[currentScene].draw()
end