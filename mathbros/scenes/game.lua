require 'res.numberButtons'

g = {}
g.loaded = false

function g.load()
   g.loaded = true
   mouseX = love.mouse.getX()
   mouseY = love.mouse.getY()
   player = {}
   table.insert(player, newC(50, 100, 100, 100, toRGB(132, 199, 255), 1))
   table.insert(player, newC(400, 100, 100, 100, toRGB(78, 104, 59), 2))
end

function g.update()
   if not g.loaded then
      g.load()
   end
   mouseX = love.mouse.getX()
   mouseY = love.mouse.getY()
   for index in ipairs(player) do
      player[index].update()
   end
end

function g.draw()
   if g.loaded then
      for index in ipairs(player) do
         player[index].draw()
      end
      love.graphics.setColor(0,0,0)
      love.graphics.print(table.concat(player[1].nums), 10, 10)
      love.graphics.print(table.concat(player[2].nums), 10, 30)
   end
end

function calculate(n, p)
   
end

function g.mouseP(mx, my)
   
end