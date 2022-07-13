Button = {}
Button.__index = Button

function Button:update()
   
end

function Button:new(x, y, w, h)
   local instance = setmetatable({}, Button)
   return instance
end