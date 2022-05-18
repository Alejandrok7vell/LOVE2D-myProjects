ball = {}

function ball:load()
   self.x, self.y = 100, 100
   self.xVel, self.yVel = 0, 0
   self.impulse = 1200
   self.vel = 5000
   self.r = 20
   self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
   self.shape = love.physics.newCircleShape(self.r)
   self.fixture = love.physics.newFixture(self.body, self.shape, 1)
   self.fixture:setRestitution(1)

   self.radio = 200

   self.body:setLinearDamping(1)

   self.iY = 0
end

function ball:update()
   -- checks if the x & y ball velocity are both equal 0
   if ball.xVel == 0 and ball.yVel == 0 then

      if love.mouse.isDown(1) and not mouseP then
         mouseP = true
         ball.body:setLinearVelocity(0, 0)
      elseif not love.mouse.isDown(1) then
         if mouseP then
            ball:shoot()
         end
         mouseP = false
      end
   end

   ball.xVel, ball.yVel = ball.body:getLinearVelocity()
end

function ball:draw()
   love.graphics.setColor(1,0,0)
   love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
end

function ball:shoot()
   local angulo = angle(mouseX, mouseY, self.body:getX(), self.body:getY())
   local impX = (self.impulse/90) * angulo
   angulo = angle(mouseX, mouseY, self.body:getX(), self.body:getY(), true)
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
   self.iY = impY
   self.body:applyLinearImpulse(impX * ball:getForce(), impY * ball:getForce())
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

function ball:drawLine()
   local angulo = angle(mouseX, mouseY, self.body:getX(), self.body:getY())
   local radio = self.radio
   local hipotenusa = hipo(mouseX-self.body:getX(), mouseY-self.body:getY())

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
      love.graphics.setColor(0, 0, 0)

      love.graphics.line(
         math.floor(self.body:getX() + xw),
         math.floor(self.body:getY() + yh),
         self.body:getX(),
         self.body:getY()
      )
   end
end