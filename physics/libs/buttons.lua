Button = {}
Button.__index = Button

function Button:update()
   if mouseX > self.x and mouseX < self.x + self.w and
      mouseY > self.y and mouseY < self.y + self.h then
      self:func()
   end
end

function Button:draw()
   self:drawF()
end

PlayButton = {}
PlayButton.__index = PlayButton
setmetatable(PlayButton, Button)

function PlayButton:func()
   changeScene(2)
end

function PlayButton:drawF()
   love.graphics.setColor(0, 1, 0)
   love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function PlayButton.new(x, y, w, h)
   local instance = setmetatable({}, PlayButton)
   instance.x, instance.y = x, y
   instance.w, instance.h = w, h
   return instance
end

ExitButton = {}
ExitButton.__index = ExitButton
setmetatable(ExitButton, Button)

function ExitButton:func()
   love.event.quit()
end

function ExitButton:drawF()
   love.graphics.setColor(1, 0, 0)
   love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function ExitButton.new(x, y, w, h)
   local instance = setmetatable({}, ExitButton)
   instance.x, instance.y = x, y
   instance.w, instance.h = w, h
   return instance
end