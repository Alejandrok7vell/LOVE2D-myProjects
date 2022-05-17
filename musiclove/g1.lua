require 'timer'
require 'linepulse'

game = {}

function game.load()
   mouseDown = false
   timer.load()
   velocity = 100
   song = love.audio.newSource("cancion.flac", "stream")
   --love.audio.play(song)

   line = {}
   line.x = 0
   line.y = 0
   line.long = love.graphics.getHeight()
   line.velocity = 300

   cubos = {}
   newCubos (
      {10, 100},
      {15,300},
      {2, 400},
      {3.5, 100},
      {4.1, 100}
   )

   animaciones = {}
end

function game.update()
   tiempo = timer.getTime()

   line.x = line.x + line.velocity * deltatime

   if love.mouse.isDown(1) and not mouseDown then
      mouseDown = true
      for index in ipairs(cubos) do
         if line.x > cubos[index].x and line.x < cubos[index].x + cubos[index].w then
            if mouseY > cubos[index].y and mouseY < cubos[index].y + cubos[index].h then
               if cubos[index].isActive then
                  table.remove(cubos, index)
                  animar(line.x, mouseY)
               end
            end
         end
      end
   elseif not love.mouse.isDown(1) then
      mouseDown = false
   end

   if #animaciones > 0 then
      for index in ipairs(animaciones) do
         animaciones[index].update()
         if animaciones[index].finished then
            table.remove(animaciones, index)
         end
      end
   end
end

function game.draw()
   love.graphics.print(tiempo)
   love.graphics.translate(100-line.x, 0)
   love.graphics.setColor(1,1,1, 0.25)
   love.graphics.line(line.x, 0, line.x, love.graphics.getHeight())
   for index in ipairs(cubos) do
      cubos[index].draw()
   end
   if #animaciones > 0 then
      for index in ipairs(animaciones) do
         animaciones[index].draw()
      end
   end
end

function animar(x, y)
   table.insert(animaciones, newAnim(x, y, 1000, rgb(255, 186, 132)))
end

function newCubo(x, y)
   local c = {}
   c.x = x
   c.y = y
   c.w = 200
   c.h = 100
   c.isActive = true
   c.color = colorRandom()

   function c.draw()
      love.graphics.setColor(c.color)
      love.graphics.rectangle("fill", c.x, c.y, c.w, c.h)
   end

   return c
end

function newCubos(...)
   local arg = {...}
   for i = 1, select("#", ...), 1 do
      table.insert(cubos, newCubo(arg[i][1] * velocity, arg[i][2]))
   end
end

function colorRandom()
   return {math.random(), math.random(), math.random()}
end