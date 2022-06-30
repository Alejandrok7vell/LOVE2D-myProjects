paredes = {}

function paredes:load(x, y, w, h, z)
   local a = (h - z) / 2
   self.p1 = {} -- Up
   self.p1.body = love.physics.newBody(world, x, y-(h/2)-10, "static")
   self.p1.shape = love.physics.newRectangleShape(w, 20)
   self.p1.fixture = love.physics.newFixture(self.p1.body, self.p1.shape)

   self.p2 = {} -- Left 1
   self.p2.body = love.physics.newBody(world, x-(w/2)-10, y-(z/2)-(a/2), "static")
   self.p2.shape = love.physics.newRectangleShape(20, a)
   self.p2.fixture = love.physics.newFixture(self.p2.body, self.p2.shape)
   self.p2b = {} -- Left 2
   self.p2b.body = love.physics.newBody(world, x-(w/2)-10, y+(z/2)+(a/2), "static")
   self.p2b.shape = love.physics.newRectangleShape(20, a)
   self.p2b.fixture = love.physics.newFixture(self.p2.body, self.p2.shape)

   self.p3 = {} -- Right 1
   self.p3.body = love.physics.newBody(world, winW + 10, winH/2, "static")
   self.p3.shape = love.physics.newRectangleShape(20, winH)
   self.p3.fixture = love.physics.newFixture(self.p3.body, self.p3.shape)
   self.p3b = {} -- Right 2
   self.p3b.body = love.physics.newBody(world, winW + 10, winH/2, "static")
   self.p3b.shape = love.physics.newRectangleShape(20, winH)
   self.p3b.fixture = love.physics.newFixture(self.p3.body, self.p3.shape)

   self.p4 = {} -- Down
   self.p4.body = love.physics.newBody(world, x, y+(h/2)+10, "static")
   self.p4.shape = love.physics.newRectangleShape(w, 20)
   self.p4.fixture = love.physics.newFixture(self.p4.body, self.p4.shape)

   self.p1.fixture:setFriction(0)
   self.p2.fixture:setFriction(0)
   self.p3.fixture:setFriction(0)
   self.p4.fixture:setFriction(0)

   self.p1.fixture:setUserData("wallUp")
   self.p2.fixture:setUserData("wallLeft")
   self.p3.fixture:setUserData("wallRight")
   self.p4.fixture:setUserData("wallDown")
end

function paredes:draw()
   love.graphics.setColor(1,1,1)
   love.graphics.polygon(
      "fill", self.p1.body:getWorldPoints(self.p1.shape:getPoints())
   )
   love.graphics.polygon(
      "fill", self.p2.body:getWorldPoints(self.p2.shape:getPoints())
   )
   love.graphics.polygon(
      "fill", self.p3.body:getWorldPoints(self.p3.shape:getPoints())
   )
   love.graphics.polygon(
      "fill", self.p4.body:getWorldPoints(self.p4.shape:getPoints())
   )

   love.graphics.polygon(
      "fill", self.p2b.body:getWorldPoints(self.p2.shape:getPoints())
   )
   love.graphics.polygon(
      "fill", self.p3b.body:getWorldPoints(self.p3.shape:getPoints())
   )
end