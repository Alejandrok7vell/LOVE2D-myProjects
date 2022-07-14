function love.load()
   x = 0
   y = 0
   z = 0
   s = 10
   vel = 10
end

function love.update(dt)
   if pj ~= nil then
      x = x + (pj:getGamepadAxis("leftx") * vel) * dt
      y = y + (pj:getGamepadAxis("lefty") * vel) * dt
   end
   lockPos()
end

function love.draw()
   love.graphics.setBackgroundColor(1,1,1)
   love.graphics.setColor(0,0,0)
   love.graphics.rectangle("fill", x, y, s, s)
end

function love.joystickadded(joystick)
   pj = joystick
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