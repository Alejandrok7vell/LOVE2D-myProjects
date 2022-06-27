paredes = {}

function paredes:load()
   self.p1 = {}
   self.p1.body = love.physics.newBody(world, winW/2, -10, "static")
   self.p1.shape = love.physics.newRectangleShape(winW, 20)
   self.p1.fixture = love.physics.newFixture(self.p1.body, self.p1.shape)

   self.p2 = {}
   self.p2.body = love.physics.newBody(world, -10, winH/2, "static")
   self.p2.shape = love.physics.newRectangleShape(20, winH)
   self.p2.fixture = love.physics.newFixture(self.p2.body, self.p2.shape)

   self.p3 = {}
   self.p3.body = love.physics.newBody(world, winW + 10, winH/2, "static")
   self.p3.shape = love.physics.newRectangleShape(20, winH)
   self.p3.fixture = love.physics.newFixture(self.p3.body, self.p3.shape)

   self.p4 = {}
   self.p4.body = love.physics.newBody(world, winW/2, winH+10, "static")
   self.p4.shape = love.physics.newRectangleShape(winW, 20)
   self.p4.fixture = love.physics.newFixture(self.p4.body, self.p4.shape)

   self.p1.fixture:setUserData("wallUp")
   self.p2.fixture:setUserData("wallLeft")
   self.p3.fixture:setUserData("wallRight")
   self.p4.fixture:setUserData("wallDown")
end