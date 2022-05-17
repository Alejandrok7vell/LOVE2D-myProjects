require 'w'

function love.load()
   mouseX, mouseY = love.mouse.getPosition()
   g.load()
end

function love.update(dt)
   mouseX, mouseY = love.mouse.getPosition()
   deltatime = dt
   g.update()
end

function love.draw()
   g.draw()
end

function rgb(r, g, b)
   return {r/255, g/255, b/255}
end