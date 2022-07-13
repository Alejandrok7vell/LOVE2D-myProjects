Button = {}
Button.__index = Button

function Button:update()
   if mouseX >= self.x and mouseX <= self.x + self.w and
      mouseY >= self.y and mouseY <= self.y + self.h then
      self.func()
   end
end

function Button:draw()
   self.draw()
end

function Button:new(x, y, w, h, func, draw)
   local instance = setmetatable({}, Button)
   self.x, self.y = x, y
   self.w, self.h = w, h
   self.func = func or function()
      currentScene = currentScene - 1
   end
   self.draw = draw or function()
      love.graphics.setColor(1, 0, 0)
      love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
   end
   return instance
end