function newBall()
   local ball = {}

   function ball:load(x, y, r, t)
      self.x, self.y = x or 100, y or 100
      self.xVel, self.yVel = 0, 0
      self.impulse = 1500
      self.r = r or 20
      self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
      self.shape = love.physics.newCircleShape(self.r)
      self.fixture = love.physics.newFixture(self.body, self.shape, 0.5)
      self.fixture:setUserData(self.ud)
      self.team = t or 1
      self.isTeam = true
      self.isStop = true
      self.ready = true
      self.selected = false
      self.locked = false

      self.flecha = {}
      self.flecha.img = love.graphics.newImage('assets/flecha1.png')
      self.flecha.color = toRGB(119, 184, 230)
      self.flecha.colors = {
         toRGB(119, 184, 230),
         toRGB(245, 245, 88),
         toRGB(237, 145, 40),
         toRGB(209, 15, 15)
      }
      self.flecha.vel = 0.01

      if self.team == 1 then
         self.color = toRGB(252, 144, 86)
      elseif self.team == 2 then
         self.color = toRGB(86, 252, 125)
      end

      -- ball bounce value
      self.fixture:setRestitution(1)

      self.radio = 200

      -- ball air friction
      self.body:setLinearDamping(0.75)
   end

   function ball:setUD(ud)
      self.ud = ud
   end

   function ball:update()
      if self.current == self.team then
         self.isTeam = true
      else
         self.isTeam = false
      end

      -- checks if the x & y ball velocity are both equal 0
      if math.floor(self.xVel + 0.5) == 0 and math.floor(self.yVel + 0.5) == 0 then

         self.isStop = true

         if self.isTeam and self.ready and self.selected and not self.locked then

            if love.mouse.isDown(1) and not mouseP then
               mouseP = true
               self.body:setLinearVelocity(0, 0)
            elseif not love.mouse.isDown(1) then
               if mouseP then
                  ball:shoot()
                  self.isStop = false
                  self.ready = false

                  if self.team == 1 then
                     changeTeam(2)
                  elseif self.team == 2 then
                     changeTeam(1)
                  end
               end
               mouseP = false
            end
         end

         if love.mouse.isDown(1) and not self.locked then
            if mouseX > self.body:getX() - self.r and
               mouseX < self.body:getX() + self.r and
               mouseY > self.body:getY() - self.r and
               mouseY < self.body:getY() + self.r then
                  self.selected = true
                  lockBalls(true)
                  self.locked = false
            end
         elseif not love.mouse.isDown(1) then
            self.selected = false
            lockBalls(false)
         end
      else
         self.isStop = false
         self.ready = false
      end

      self.xVel, self.yVel = self.body:getLinearVelocity()
   end

   function ball:draw()
      love.graphics.setColor(self.color)
      love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
   end

   function ball:shoot()
      local angulo = angles(mouseX, mouseY, self.body:getX(), self.body:getY())
      local impX = (self.impulse/90) * angulo
      angulo = angles(mouseX, mouseY, self.body:getX(), self.body:getY(), true)
      local impY = (self.impulse/90) * angulo

      if mouseX > self.body:getX() then
         impX = -impX
      elseif mouseX < self.body:getX() then
         impX = impX
      else
         impX = 0
      end

      if mouseY > self.body:getY() then
         impY = -impY
      elseif mouseY < self.body:getY() then
         impY = impY
      else
         impY = 0
      end
      self.body:applyLinearImpulse(impX * self:getForce(), impY * self:getForce())
   end

   function ball:getForce()
      local d1, d2 = mouseX - self.body:getX(), mouseY - self.body:getY()
      local distancia = hipo(d1, d2)
      local longitud = self.radio
      if distancia > longitud then
         return 1
      else
         return (distancia/longitud)
      end
   end

   function ball:updateLine()
      if self.isTeam and self.ready and self.selected and not self.locked then


         local fuerza = self:getForce()
         if fuerza > 0 and fuerza < 0.25 then
            self.flecha.color = self:changeColor(self.flecha.color, self.flecha.colors[1])
         elseif fuerza > 0.25 and fuerza < 0.5 then
            self.flecha.color = self:changeColor(self.flecha.color, self.flecha.colors[2])
         elseif fuerza > 0.5 and fuerza < 0.75 then
            self.flecha.color = self:changeColor(self.flecha.color, self.flecha.colors[3])
         elseif fuerza > 0.75 then
            self.flecha.color = self:changeColor(self.flecha.color, self.flecha.colors[4])
         end
      end
   end

   function ball:changeColor(c1, c2)
      local r, g, b = c1[1]*255, c1[2]*255, c1[3]*255
      local r2, g2, b2 = c2[1]*255, c2[2]*255, c2[3]*255
      self.flecha.vel = 10

      -- changes red color
      if r < r2 then
         r = r + self.flecha.vel
      elseif r > r2 then
         r = r - self.flecha.vel
      end

      -- changes green color
      if g < g2 then
         g = g + self.flecha.vel
      elseif g > g2 then
         g = g - self.flecha.vel
      end

      -- changes blue color
      if b < b2 then
         b = b + self.flecha.vel
      elseif b > b2 then
         b = b - self.flecha.vel
      end

      return {r/255, g/255, b/255}
   end

   function ball:drawLine()
      --love.graphics.push()
      if self.isTeam and self.ready and self.selected and not self.locked then
         local angulo = angles(mouseX, mouseY, self.body:getX(), self.body:getY())
         local radio = self.radio
         local hipotenusa = hipo(mouseX-self.body:getX(), mouseY-self.body:getY())
         local angle = math.atan2((mouseY - self.body:getY()), (mouseX - self.body:getX()))
         angle = angle + 2.35619

         -- looks mouse distance value to radio value
         if hipotenusa > radio then hipotenusa = radio end

         -- get the C values
         local xw = math.sin(math.rad(angulo))*hipotenusa
         local yh = math.pow(hipotenusa, 2) - math.pow(xw, 2)

         -- converts yh to positive value for work with math.sqrt(x)
         if yh < 0 then yh = - yh end

         -- get the CO long
         yh = math.sqrt(math.floor(yh + 0.5))

         -- looks the values to radio value
         if xw > radio then xw = radio end
         if yh > radio then yh = radio end

         if mouseX < self.body:getX() then xw = -xw end
         if mouseY < self.body:getY() then yh = -yh end

         if love.mouse.isDown(1) then
            love.graphics.setColor(self.flecha.color)

            love.graphics.line(
               math.floor(self.body:getX() + xw),
               math.floor(self.body:getY() + yh),
               self.body:getX(),
               self.body:getY()
            )

            love.graphics.draw(self.flecha.img, self.body:getX(), self.body:getY(), angle)
         end
      end
      --love.graphics.pop()
   end

   function ball:setCurrentTeam(t)
      self.current = t
   end

   function ball.beginContact(a, b)
      local data1, data2 = a, b
      if data1 == ball.ud or data2 == ball.ud then
         if data1 == "wallUp" or data2 == "wallUp" then
            ball.body:applyLinearImpulse(0, 10)
         elseif data1 == "wallLeft" or data2 == "wallLeft" then
            ball.body:applyLinearImpulse(10, 0)
         elseif data1 == "wallRight" or data2 == "wallRight" then
            ball.body:applyLinearImpulse(-10, 0)
         elseif data1 == "wallDown" or data2 == "wallDown" then
            ball.body:applyLinearImpulse(0, -10)
         end
      end
   end

   function ball.preSolve(a, b)
      local data1, data2 = a, b
      if data1 == ball.ud or data2 == ball.ud then
         if data1 == "wallUp" or data2 == "wallUp" then
            ball.body:applyLinearImpulse(0, 10)
         elseif data1 == "wallLeft" or data2 == "wallLeft" then
            ball.body:applyLinearImpulse(10, 0)
         elseif data1 == "wallRight" or data2 == "wallRight" then
            ball.body:applyLinearImpulse(-10, 0)
         elseif data1 == "wallDown" or data2 == "wallDown" then
            ball.body:applyLinearImpulse(0, -10)
         end
      end
   end

   return ball
end

function newBalon()
   local b = {}
   function b:load(x1, x2)
      self.x, self.y = winW / 2, winH / 2
      self.wx1, self.wx2 = x1, x2
      self.r = 20
      self.color = toRGB(255, 255, 255)

      self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
      self.shape = love.physics.newCircleShape(self.r)
      self.fixture = love.physics.newFixture(self.body, self.shape, 0.9)
      self.fixture:setRestitution(1)
      self.body:setLinearDamping(0.75)

      self.fixture:setUserData("balon")
   end

   function b:update()
      if self.body:getX() < self.wx1 - self.r or self.body:getX() > self.wx2 + self.r then
         self.body:setPosition(winW / 2, winH / 2)
      end
   end

   function b:draw()
      love.graphics.setColor(1, 1, 1)
      love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
   end

   function b.beginContact(a, c, x)
      local data1, data2 = a, c
      local cx = x
      if data1 == "balon" or data2 == "balon" then
         if data1 == "wallUp" or data2 == "wallUp" then
            b.body:applyLinearImpulse(0, 5)
         elseif data1 == "wallLeft" or data2 == "wallLeft" then
            if cx == 1 then
               b.body:applyLinearImpulse(5, 0)
            end
         elseif data1 == "wallRight" or data2 == "wallRight" then
            if cx == -1 then
               b.body:applyLinearImpulse(-5, 0)
            end
         elseif data1 == "wallDown" or data2 == "wallDown" then
            b.body:applyLinearImpulse(0, -5)
         end
      end
   end

   function b.preSolve(a, c, x)
      local data1, data2 = a, c
      local cx = x
      if data1 == "balon" or data2 == "balon" then
         if data1 == "wallUp" or data2 == "wallUp" then
            b.body:applyLinearImpulse(0, 5)
         elseif data1 == "wallLeft" or data2 == "wallLeft" then
            if cx == 1 then
               b.body:applyLinearImpulse(5, 0)
            end
         elseif data1 == "wallRight" or data2 == "wallRight" then
            if cx == -1 then
               b.body:applyLinearImpulse(-5, 0)
            end
         elseif data1 == "wallDown" or data2 == "wallDown" then
            b.body:applyLinearImpulse(0, -5)
         end
      end
   end

   return b
end