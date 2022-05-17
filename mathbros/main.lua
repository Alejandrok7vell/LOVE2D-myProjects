require 'scenes.game'
require 'scenes.mh'

function love.load()
   love.graphics.setBackgroundColor(0.8,0.8,0.8)
   scene = {}
   currentScene = 2
   table.insert(scene, m)
   table.insert(scene, g)
end

function love.update()
   scene[currentScene].update()
end

function love.draw()
   love.graphics.setColor(1, 1, 1)
   scene[currentScene].draw()
end

function love.mousepressed(mx, my)
   scene[currentScene].mouseP()
end

function love.mousereleased()
   
end

function changeScene(s)
   scene[s].loaded = false
   currentScene = s
end

function toRGB(r, g, b, a)
   local alpha = a or 255
   return {r/255, g/255, b/255, alpha/255}
end