require "players"
require "bullets"
require "particles"
require "numeros"

local moonshine = require 'moonshine'

function love.load()
   love.mouse.setVisible(false)

   w = {}
   w.width = love.graphics.getWidth()
   w.height = love.graphics.getHeight()

   numerosP1 = {}
   numerosP2 = {}
   for i = 0, 3, 1 do
      table.insert(numerosP1, newNumeros(i, w.width/2 - 22, 50))
   end
   for i = 0, 3, 1 do
      table.insert(numerosP2, newNumeros(i, w.width/2 + 22, 50))
   end
   winsP1 = 1
   winsP2 = 1
   csr = 0
   effect = moonshine(moonshine.effects.chromasep)
      .chain(moonshine.effects.glow)
   effect.chromasep.angle = 0
   effect.chromasep.radius = csr
   effect.glow.min_luma = 0.2
   effect.glow.strength = 4

   color1 = {0.34, 0.95, 1} -- blue color
   color2 = {1, 0.7, 0.34} -- orange color

   bcolor1 = {1, 0.34, 0.95} -- blue color
   bcolor2 = {0.7, 1, 0.34} -- orange color

   finished = false

   players = {}
   bullets = {}
   table.insert(players, newPlayer(1))
   table.insert(players, newPlayer(2))
end

function love.update()
   for index in ipairs(players) do
      players[index].update()
   end
   for index in ipairs(bullets) do
      if index ~= 0 then
         bullets[index].update()
      end
   end
   if finished then
      effect.chromasep.radius = csr
      if csr ~= 0 then
         csr = csr - 0.1
      end
   end
end

function love.draw()
   effect(function()
      for index in ipairs(players) do
         players[index].draw()
      end
      for index in ipairs(bullets) do
         if index ~= 0 then
            bullets[index].draw()
         end
      end
      love.graphics.setColor(1, 1, 1)
      love.graphics.rectangle("fill", w.width/2 + 2, 45, 2, 24)
      numerosP1[winsP1].draw()
      numerosP2[winsP2].draw()
   end)
end

function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end
end

function win(p)
   local player = p
   finished = true
   players[player].finish = true
end

function load()
   if winsP1 == 4 or winsP2 == 4 then
      winsP1 = 1
      winsP2 = 1
   end
   finished = false
   csr = 0
   effect.chromasep.radius = csr

   players = {}
   bullets = {}
   table.insert(players, newPlayer(1))
   table.insert(players, newPlayer(2))
end