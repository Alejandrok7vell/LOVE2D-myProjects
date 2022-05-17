function newNumeros(number, x, y)
   local num = {}
   num.n = number
   num.x = x
   num.y = y
   num.nums = {}

   function num.newNum(nx, ny)
      local nn = {}
      function nn.draw()
         love.graphics.rectangle("fill", nx, ny, 2, 2)
      end
      return nn
   end

   if num.n == 0 then
      for i = 0, 6, 2 do
         table.insert(num.nums, num.newNum(num.x + i, num.y))
      end
      for i = 0, 4, 2 do
         table.insert(num.nums, num.newNum(num.x + i, num.y + 12))
      end
      for i = 2, 12, 2 do
         table.insert(num.nums, num.newNum(num.x + 6, num.y + i))
      end
      for i = 2, 10, 2 do
         table.insert(num.nums, num.newNum(num.x, num.y + i))
      end
   elseif num.n == 1 then
      for i = 0, 12, 2 do
         table.insert(num.nums, num.newNum(num.x + 6, num.y + i))
      end
   elseif num.n == 2 then
      for a = 0, 12, 6 do
         for i = 0, 6, 2 do
            table.insert(num.nums, num.newNum(num.x + i, num.y + a))
         end
      end
      for i = 2, 4, 2 do
         table.insert(num.nums, num.newNum(num.x + 6, num.y + i))
         table.insert(num.nums, num.newNum(num.x, num.y + i + 6))
      end
   elseif num.n == 3 then
      for a = 0, 12, 6 do
         for i = 0, 6, 2 do
            table.insert(num.nums, num.newNum(num.x + i, num.y + a))
         end
      end
      for i = 2, 4, 2 do
         table.insert(num.nums, num.newNum(num.x + 6, num.y + i))
         table.insert(num.nums, num.newNum(num.x + 6, num.y + i + 6))
      end
   end

   function num.draw()
      for index in ipairs(num.nums) do
         num.nums[index].draw()
      end
   end

   return num
end