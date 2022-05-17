function newBullet(x, y, d, t)
   local b = {}
   b.x = x + 4
   b.y = y + 4
   b.vel = 2
   b.dir = d
   b.type = t
   b.loaded = true
   b.sound = love.audio.newSource("laser.wav", "static")

   if b.dir == 0 then
      b.y = b.y - 8
      b.xVel = 0
      b.yVel = -2
   elseif b.dir == 1 then
      b.x = b.x + 8
      b.xVel = 2
      b.yVel = 0
   elseif b.dir == 2 then
      b.y = b.y + 8
      b.xVel = 0
      b.yVel = 2
   elseif b.dir == 3 then
      b.x = b.x - 8
      b.xVel = -2
      b.yVel = 0
   end

   function b.update()
      if b.loaded then
         b.sound:play()
         b.loaded = false
      end
      if not b.sound:isPlaying() then
         b.sound:pause()
      end
      if not finished then
         b.x = b.x + b.xVel * b.vel
         b.y = b.y + b.yVel * b.vel
      end

      if b.x > w.width + 8 then
         b.x = -4
      end
      if b.x < -8 then
         b.x = w.width + 4
      end
      if b.y > w.height + 8 then
         b.y = -4
      end
      if b.y < -8 then
         b.y = w.height + 4
      end

      for index in ipairs(players) do
         if b.x > players[index].x - 2 and
         b.x < players[index].x + 10 and
         b.y > players[index].y - 2 and
         b.y < players[index].y + 10 then
            win(index)
         end
      end
   end

   function b.draw()
      if b.type == 1 then
         love.graphics.setColor(color2)
      elseif b.type == 2 then
         love.graphics.setColor(bcolor2)
      end
      love.graphics.rectangle("fill", b.x, b.y, 4, 4)
   end

   return b
end