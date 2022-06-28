function toRGB(...)
   local args = {...}
   if select("#", ...) == 3 then
      table.insert(args, 255)
   end

   return {args[1]/255, args[2]/255, args[3]/255, args[4]/255}
end

function randomColor()
   return {
      math.random(0, 255)/255,
      math.random(0, 255)/255,
      math.random(0, 255)/255,
      1
   }
end