require 'res.Buttons'

function newC(x, y, w, h, col, s)
   local c = {}
   c.x = x or 100
   c.y = y or 100
   c.w = w or 50
   c.h = h or 50
   c.color = col or {1, 0, 0}
   c.p = s or 1

   c.nums = {}

   c.buttons = {}
   local numeros = 1
   for i = 1, 3, 1 do
      for j = 1, 3, 1 do
         table.insert(c.buttons, newButton((c.x+c.w*j)-c.w, (c.y+c.h*i)-c.h, c.w, c.h,
         c.color, "calc", numeros, c.p))
         numeros = numeros + 1
      end
   end
   table.insert(c.buttons, newButton(c.x+c.w, c.y+c.h*3, c.w, c.h,
   c.color, "calc", 0, c.p))

   table.insert(c.buttons, newButton(c.x, c.y + c.h*3, c.w, c.h,
   c.color, "calc-erase", 0, c.p))

   function c.update()
      for index in ipairs(c.buttons) do
         c.buttons[index].update()
      end
   end

   function c.draw()
      for index in ipairs(c.buttons) do
         c.buttons[index].draw()
      end
   end

   return c
end