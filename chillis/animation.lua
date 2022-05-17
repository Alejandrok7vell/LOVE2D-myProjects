function newAnimation(image, width, height, duration)
   local animation = {}
   animation.spriteSheet = image;
   animation.quads = {};

   for y = 0, image:getHeight() - height, height do
       for x = 0, image:getWidth() - width, width do
           table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
       end
   end

   animation.duration = duration or 1
   animation.currentTime = 0

   function animation.update()
      animation.currentTime = animation.currentTime + deltatime
      if animation.currentTime >= animation.duration then
          animation.currentTime = animation.currentTime - animation.duration
      end
   end

   function animation.draw(x, y)
      local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
      love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], x, y, 0, 1)
   end

   return animation
end