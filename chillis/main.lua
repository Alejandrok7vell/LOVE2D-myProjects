require 'scenes.mainScene'
require 'scenes.game'

function love.load()
   wWidth, wHeight = love.graphics.getDimensions()
   scene = {}
   table.insert(scene, s1)
   table.insert(scene, s2)
   currentScene = 1
end

function love.update(dt)
   deltatime = dt
   scene[currentScene].update()
end

function love.draw()
   scene[currentScene].draw()
end

function changeScene(s)
   scene[s].loaded = false
   currentScene = s
end

function rgb(...)
   local arg = {...}
   if select("#", ...) == 3 then
      table.insert(arg, 255)
   end

   return {arg[1]/255, arg[2]/255, arg[3]/255, arg[4]/255}
end