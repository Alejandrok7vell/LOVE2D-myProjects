function newAnim(x, y, v, color)
   local anim = {}
   anim.x, anim.y = x, y
   anim.y1, anim.y2 = y, y
   anim.velocity = v or 200
   anim.color = color or {0,0,0,1}
   anim.finshed = false
   if #anim.color == 3 then
      table.insert(anim.color, 1)
   end

   function anim.update()
      anim.x = line.x
      anim.y1 = anim.y1 + anim.velocity * deltatime
      anim.y2 = anim.y2 - anim.velocity * deltatime
      anim.color[4] = anim.color[4] - 0.025

      if anim.y1 < 0 and anim.color[4] < 0 then
         anim.finshed = true
      end
   end

   function anim.draw()
      love.graphics.setColor({anim.color[1],
      anim.color[2],
      anim.color[3],
      anim.color[4]
      })
      -- Drawing line 1
      love.graphics.line(anim.x, anim.y, anim.x, anim.y1)
      love.graphics.line(anim.x, anim.y, anim.x, anim.y2)
   end

   return anim
end