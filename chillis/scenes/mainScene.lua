require 'player'

s1 = {}
s1.loaded = false

function s1.load()
   love.graphics.setBackgroundColor(rgb(102, 152, 255))
   s1.loaded = true
   cat.load(wWidth/2 - 50, wHeight/2 - 50)
end

function s1.update()
   if not s1.loaded then
      s1.load()
   end
   cat.update()
end

function s1.draw()
   if s1.loaded then
      cat.draw()
   end
end