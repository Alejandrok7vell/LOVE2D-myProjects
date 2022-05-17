m = {}
m.loaded = false

function m.load()
   m.loaded = true
end

function m.update()
   if not m.loaded then
      m.load()
   end
end

function m.draw()
   if m.loaded then
      love.graphics.setBackgroundColor(toRGB(50, 58, 77))
   end
end

function m.mouseP(mx, my)
   
end