player = {}

function player:load()
   self.x, self.y = winX, winH
   self.r = 100

   self.body = love.physics.newBody(world, self.x, self.y, "kinematic")
   self.shape = love.physics.newCircleShape(self.r)
   self.fixture = love.physics.newFixture(self.body, self.shape)

   self.angle = 0

   self.bullet = {
      x = self.x, y = self.y,
      speed = 100
   }
end

function player:update(dt)
   
end

function player:draw()
   love.graphics.setColor(1,1,1)
   love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
end