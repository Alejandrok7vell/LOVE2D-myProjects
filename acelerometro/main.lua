function love.load()
   x = 0
   y = 0
   s = 10
   vel = 10
   pj = love.joystick:getJoysticks()[1]
end

function love.update(dt)
   if pj ~= nil then
      x = x + (pj:getAxis(1) * vel) * dt
      y = y + (pj:getAxis(2) * vel) * dt
   end
   lockPos()
end

function love.draw()
   love.graphics.setBackgroundColor(1,1,1)
   love.graphics.setColor(0,0,0)
   love.graphics.rectangle("fill", x, y, s, s)
   love.graphics.print(pj:getAxis(3))
end

function lockPos()
   if x > love.graphics.getWidth() - s then
      x = love.graphics.getWidth() - s
   elseif x < 0 then x = 0
   end
   if y > love.graphics.getHeight() - s then
      y = love.graphics.getHeight() - s
   elseif y < 0 then y = 0
   end
end