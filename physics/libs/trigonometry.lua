function hipo(v1, v2)
   local co = v1 * v1
   local ca = v2 * v2

   local h = math.sqrt(co + ca)

   return h
end

function angles(x1, y1, x2, y2, l, f)
   local p1, p2 = {x1, y1}, {x2, y2}

   local side = l or false
   local floor = f or true

   local disX = p1[1] - p2[1]
   local disY = p1[2] - p2[2]

   if disX < 0 then
      disX = -disX
   end
   if disY < 0 then
      disY = -disY
   end

   local a = math.atan(disX/disY) * (180/math.pi)
   if side then
      a = math.atan(disY/disX) * (180/math.pi)
   end

   if floor then
      a = math.floor(a+0.5)
   end

   return a
end