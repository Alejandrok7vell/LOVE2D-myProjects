require 'player'

s2 = {}
s2.loaded = false

function s2.load()
   s2.loaded = true
end

function s2.update()
   if not s2.loaded then
      s2.load()
   end
end

function s2.draw()
   if s2.loaded then
      
   end
end