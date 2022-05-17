function newButton(x, y, w, h, c, t, n, p)
   local b = {}

   b.x = x or 200
   b.y = y or 200
   b.w = w or 100
   b.h = h or 100
   b.color = {}
   for i = 1, 3, 1 do table.insert(b.color, c[i]) end
   b.COLOR = {b.color[1], b.color[2], b.color[3]}
   if b.color[1] + b.color[2] + b.color[3] > 1.1 then b.colorA = {0, 0, 0}
   else b.colorA = {1, 1, 1} end

   if b.colorA[1] == 0 then
      b.theme = "light"
   else
      b.theme = "dark"
   end

   b.t = t or "main"
   b.side = p or 1
   b.num = n or 1

   b.mIsDown = false

   if b.t == "calc" then
      function b.update()
         b.colorear()
         if love.mouse.isDown(1) then
            if b.isMouseIn() and not b.mIsDown then
               b.mPressed(b.t)
            end
         else
            b.mIsDown = false
         end
      end

      function b.draw()
         love.graphics.setColor(b.COLOR)
         love.graphics.rectangle("fill", b.x, b.y, b.w, b.h)
         love.graphics.setColor(b.colorA)
         love.graphics.rectangle("line", b.x, b.y, b.w, b.h)
         love.graphics.print(b.num, b.x + (b.w/2), b.y + (b.h/2))
      end
   elseif b.t == "calc-erase" then
      if b.theme == "dark" then
         b.color = {b.color[1] + 0.15, b.color[2] + 0.1, b.color[3] - 0.15}
      elseif b.theme == "light" then
         b.color = {b.color[1] - 0.15, b.color[2] - 0.1, b.color[3] - 0.15}
      end

      b.COLOR = {b.color[1], b.color[2], b.color[3]}
      function b.update()
         b.colorear()
         if love.mouse.isDown(1) then
            if b.isMouseIn() and not b.mIsDown then
               b.mPressed(b.t)
            end
         else
            b.mIsDown = false
         end
      end

      function b.draw()
         love.graphics.setColor(b.COLOR)
         love.graphics.rectangle("fill", b.x, b.y, b.w, b.h)
         love.graphics.setColor(b.colorA)
         love.graphics.rectangle("line", b.x, b.y, b.w, b.h)
         love.graphics.print("<--", b.x + (b.w/2), b.y + (b.h/2))
      end
   elseif b.t == "calc-send" then
      function b.update()
         
      end

      function b.draw()
         
      end
   end

   if b.theme == "light" then
      function b.colorear()
         b.COLOR[1] = b.COLOR[1] - 0.02
         if b.COLOR[1] < b.color[1] then
            b.COLOR[1] = b.color[1]
         end
         b.COLOR[2] = b.COLOR[2] - 0.02
         if b.COLOR[2] <= b.color[2] then
            b.COLOR[2] = b.color[2]
         end
         b.COLOR[3] = b.COLOR[3] - 0.02
         if b.COLOR[3] <= b.color[3] then
            b.COLOR[3] = b.color[3]
         end
      end
   elseif b.theme == "dark" then
      function b.colorear()
         b.COLOR[1] = b.COLOR[1] + 0.02
         if b.COLOR[1] > b.color[1] then
            b.COLOR[1] = b.color[1]
         end
         b.COLOR[2] = b.COLOR[2] + 0.02
         if b.COLOR[2] >= b.color[2] then
            b.COLOR[2] = b.color[2]
         end
         b.COLOR[3] = b.COLOR[3] + 0.02
         if b.COLOR[3] >= b.color[3] then
            b.COLOR[3] = b.color[3]
         end
      end
   end

   function b.isMouseIn()
      if mouseX >= b.x and mouseX <= b.x + b.w
      and mouseY >= b.y and mouseY <= b.y + b.h then
         return true
      else
         return false
      end
   end

   function b.mPressed(bt)
      if bt == "calc" then
         table.insert(player[b.side].nums, b.num)
      elseif bt == "calc-erase" then
         table.remove(player[b.side].nums)
      elseif bt == "calc-send" then

      end
      if b.theme == "light" then
         b.COLOR[1] = 1
         b.COLOR[2] = 1
         b.COLOR[3] = 1
      elseif b.theme == "dark" then
         b.COLOR[1] = 0
         b.COLOR[2] = 0
         b.COLOR[3] = 0
      end

      b.mIsDown = true
   end

   --[[function b.color2(color, a)
      local c2 = color or {1, 0, 0}
      if a == 1 then
         c2[1] = c2[1] - 0.2
      end
   end --]]

   return b
end