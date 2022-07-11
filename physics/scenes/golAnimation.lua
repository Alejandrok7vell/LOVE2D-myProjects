anim = {}
anim.gol = {}

function anim.gol:load(s)
   self.size = 300
   self.vel = 400
   self.acel = 20
   self.maxVel = 4000
   self.dir = "right"

   self.font = love.graphics.newFont(
      "assets/fonts/8bitOperatorPlus8-Bold.ttf", self.size,"normal"
   )
   self.color = {1, 1, 1, 1}

   self.txt = love.graphics.newText(self.font, "GOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOL")

   self.width = self.txt:getWidth()

   if s == 1 then
      self.x = - self.width
   elseif s == 2 then
      self.x = winW
      self.vel = -self.vel
      self.acel = -self.acel
      self.dir = "left"
      self.maxVel = -self.maxVel
   end

   self.y = winH / 2 - (self.txt:getHeight()/2)
end

function anim.gol:update(dt)
   self.x = self.x + self.vel * dt
   if self.x > winW + self.size or self.x < -self.width - self.size then
      setPositions()
      isGol = false
   end
   self.vel = self.vel + self.acel
   if self.dir == "right" then
      if self.vel > self.maxVel then
         self.acel = -self.acel
      end
      if self.vel < 300 then
         self.acel = 0
      end
   else
      if self.vel < self.maxVel then
         self.acel = -self.acel
      end
      if self.vel > -300 then
         self.acel = 0
      end
   end
end

function anim.gol:draw()
   love.graphics.setColor(self.color)
   love.graphics.draw(self.txt, self.x, self.y)
end