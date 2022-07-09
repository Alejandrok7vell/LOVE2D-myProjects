anim = {}
anim.gol = {}

function anim.gol:load(s)
   self.size = 100
   self.vel = 100
   if s == 1 then
      self.x = -self.size
   elseif s == 2 then
      self.x = winW + self.size
      self.vel = -self.vel
   end

   self.font = love.graphics.newFont("assets/fonts/1.ttf", self.size,"normal")
   self.color = {1, 1, 1, 1}
end

function anim.gol:update()
   self.x = self.x + self.vel
end

function anim.gol:draw()
   
end