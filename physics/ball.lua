ball = {}

function ball:load()
   self.x, self.y = 100, 100
   self.xVel, self.yVel = 0, 0
   self.xDir, self.yDir = "neutro", "neutro"
   self.impulse = 500
   self.vel = 5000
   self.r = 20
   self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
   self.shape = love.physics.newCircleShape(self.r)
   self.fixture = love.physics.newFixture(self.body, self.shape, 1)

   self.iY = 0
end

function ball:update(dt)
   -- checks if the x & y ball velocity are both equal 0
   if ball.xVel == 0 and ball.yVel == 0 then

      if love.mouse.isDown(1) and not mouseP then
         mouseP = true
         ball.body:setLinearVelocity(0, 0)
         ball:shoot()
      elseif not love.mouse.isDown(1) then
         mouseP = false
      end
   end

   ball.xVel, ball.yVel = ball.body:getLinearVelocity()

   -- position X
   if ball.xVel > 0 then
      ball.xDir = "right"
   elseif ball.xVel < 0 then
      ball.xDir = "left"
   else
      ball.xDir = "neutro"
   end

   -- position Y
   if ball.yVel > 0 then
      ball.yDir = "down"
   elseif ball.yVel < 0 then
      ball.yDir = "up"
   else
      ball.yDir = "neutro"
   end

   -- Set X direction friction
   if ball.xDir == "right" then
      ball.xVel = ball.xVel - ball.vel * dt
      if ball.xVel < 0 then
         ball.xDir = "neutro"
         ball.xVel = 0
      end
   elseif ball.xDir == "left" then
      ball.xVel = ball.xVel + ball.vel * dt
      if ball.xVel > 0 then
         ball.xDir = "neutro"
         ball.xVel = 0
      end
   end

   --
   -- Set Y direction friction
   if ball.yDir == "down" then
      ball.yVel = ball.yVel - ball.vel * dt
      if ball.yVel < 0 then
         ball.yDir = "neutro"
         ball.yVel = 0
      end
   elseif ball.yDir == "up" then
      ball.yVel = ball.yVel + ball.vel * dt
      if ball.yVel > 0 then
         ball.yDir = "neutro"
         ball.yVel = 0
      end
   end
   --]]

   ball.body:setLinearVelocity(ball.xVel, ball.yVel)
end

function ball:draw()
   love.graphics.setColor(1,0,0)
   love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())

   love.graphics.print(self.iY, 10, 100)
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
   self.body:applyLinearImpulse(impX, impY)
end