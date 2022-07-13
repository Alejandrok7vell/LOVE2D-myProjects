return {
   
      -- Play button
      Button:new(
         winW/2, winH/2, 200, 200,
         function()
            currentScene = currentScene + 1
         end,
         function()
            love.graphics.setColor(0, 1, 0)
            love.graphics.rectangle("fill", x, y, w, h)
         end
      )
   --[[,
   {

      Button:new()
   },
   {
      Button:new()
   },
   {
      Button:new()
   }--]]
}