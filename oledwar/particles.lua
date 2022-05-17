function endParticle(x, y, t, c)
   local pa = {}
   pa.x = x + 5
   pa.y = y + 5
   pa.alpha = 1
   pa.c = c

   if t == 1 then
      pa.xVel = 0
      pa.yVel = 1
   elseif t == 2 then
      pa.xVel = 0.5
      pa.yVel = 1
   elseif t == 3 then
      pa.xVel = 1
      pa.yVel = 1
   elseif t == 4 then
      pa.xVel = 1
      pa.yVel = 0.5
   elseif t == 5 then
      pa.xVel = 1
      pa.yVel = 0
   elseif t == 6 then
      pa.xVel = 1
      pa.yVel = -0.5
   elseif t == 7 then
      pa.xVel = 1
      pa.yVel = -1
   elseif t == 8 then
      pa.xVel = 0.5
      pa.yVel = -1
   elseif t == 9 then
      pa.xVel = 0
      pa.yVel = -1
   elseif t == 10 then
      pa.xVel = -0.5
      pa.yVel = -1
   elseif t == 11 then
      pa.xVel = -1
      pa.yVel = -1
   elseif t == 12 then
      pa.xVel = -1
      pa.yVel = -0.5
   elseif t == 13 then
      pa.xVel = -1
      pa.yVel = 0.5
   elseif t == 14 then
      pa.xVel = -1
      pa.yVel = 1
   elseif t == 15 then
      pa.xVel = -0.5
      pa.yVel = 1
   elseif t == 16 then
      pa.xVel = -1
      pa.yVel = 0
   end

   function pa.update()
      pa.x = pa.x + pa.xVel
      pa.y = pa.y + pa.yVel

      pa.alpha = pa.alpha - 0.01

      if pa.alpha < -0.5 then
         load()
      end
   end

   function pa.draw()
      if pa.c == 1 then
         love.graphics.setColor(color1[1], color1[2], color1[3], pa.alpha)
      elseif pa.c == 2 then
         love.graphics.setColor(bcolor1[1], bcolor1[2], bcolor1[3], pa.alpha)
      end
      love.graphics.rectangle("fill", pa.x, pa.y, 2, 2)
   end

   return pa
end