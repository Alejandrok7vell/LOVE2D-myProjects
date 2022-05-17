function newPlayer(t)
   local p = {}
   p.n = t
   p.dir = 0
   p.xVel = 0
   p.yVel = 0
   p.velocity = 2
   p.keyPressed = false
   p.finish = false
   p.dead = true
   p.locked = false
   p.dl = 4
   p.ds = love.audio.newSource("bad.wav", "static")
   p.particles = {}

   if p.n == 1 then
      p.x = 100
      p.y = 100
      p.up = "w"
      p.left = "a"
      p.down = "s"
      p.right = "d"
      p.shoot = "space"
   elseif p.n == 2 then
      p.x = w.width - 100
      p.y = 100
      p.up = "up"
      p.left = "left"
      p.down = "down"
      p.right = "right"
      p.shoot = "return"
   end

   function p.update()
      if not p.finish then
         if p.x < -13 then
            p.x = w.width + 12
         end
         if p.x > w.width + 13 then
            p.x = -12
         end
         if p.y < -13 then
            p.y = w.height + 12
         end
         if p.y > w.height + 13 then
            p.y = -12
         end


         if love.keyboard.isDown(p.up) then
            p.yVel = -1
            p.xVel = 0
            p.lock(0)
            p.move()
         end
         if love.keyboard.isDown(p.left) then
            p.xVel = -1
            p.yVel = 0
            p.lock(3)
            p.move()
         end
         if love.keyboard.isDown(p.down) then
            p.yVel = 1
            p.xVel = 0
            p.lock(2)
            p.move()
         end
         if love.keyboard.isDown(p.right) then
            p.xVel = 1
            p.yVel = 0
            p.lock(1)
            p.move()
         end
         if not love.keyboard.isDown(p.up) and not
         love.keyboard.isDown(p.left) and not
         love.keyboard.isDown(p.down) and not
         love.keyboard.isDown(p.right) then
            p.xVel = 0
            p.yVel = 0
         end

         if love.keyboard.isDown(p.shoot) and not p.keyPressed then
            table.insert(bullets, newBullet(p.x, p.y, p.dir, p.n))
            p.keyPressed = true
         elseif not love.keyboard.isDown(p.shoot) then
            p.keyPressed = false
         end
      else
         if p.dead then
            for i = 1, 16, 1 do
               table.insert(p.particles, endParticle(p.x, p.y, i, p.n))
            end
            p.dead = false
            if p.n == 1 then
               winsP2 = winsP2 + 1
            elseif p.n == 2 then
               winsP1 = winsP1 + 1
            end
            csr = 15
            p.ds:play()
         end
         for index in ipairs(p.particles) do
            p.particles[index].update()
         end
         if not p.ds:isPlaying() then
            p.ds:pause()
         end
      end
   end

   function p.draw()
      if p.n == 1 then
         love.graphics.setColor(color1)
      elseif p.n == 2 then
         love.graphics.setColor(bcolor1)
      end

      if not p.finish then
         if p.dir == 0 then
            love.graphics.rectangle("fill", p.x, p.y + 4, 4, 8)
            love.graphics.rectangle("fill", p.x + 4, p.y, 4, 8)
            love.graphics.rectangle("fill", p.x + 8, p.y + 4, 4, 8)
         elseif p.dir == 1 then
            love.graphics.rectangle("fill", p.x, p.y, 8, 4)
            love.graphics.rectangle("fill", p.x + 4, p.y + 4, 4, 8)
            love.graphics.rectangle("fill", p.x + 8, p.y + 4, 4, 4)
            love.graphics.rectangle("fill", p.x, p.y + 8, 4, 4)
         elseif p.dir == 2 then
            love.graphics.rectangle("fill", p.x, p.y, 4, 8)
            love.graphics.rectangle("fill", p.x + 4, p.y + 4, 4, 8)
            love.graphics.rectangle("fill", p.x + 8, p.y, 4, 8)
         elseif p.dir == 3 then
            love.graphics.rectangle("fill", p.x + 4, p.y, 8, 4)
            love.graphics.rectangle("fill", p.x, p.y + 4, 8, 4)
            love.graphics.rectangle("fill", p.x + 4, p.y + 8, 8, 4)
         end
      else
         for index in ipairs(p.particles) do
            p.particles[index].draw()
         end
      end
   end

   function p.move()
      if not finished then
         p.x = p.x + p.xVel * p.velocity
         p.y = p.y + p.yVel * p.velocity
      end
   end

   function p.lock(dir)
      if not p.locked then
         p.dir = dir
         p.dl = dir
         p.locked = true
      else
         if p.dl == 0 and not love.keyboard.isDown(p.up) then
            p.locked = false
         elseif p.dl == 1 and not love.keyboard.isDown(p.right) then
            p.locked = false
         elseif p.dl == 2 and not love.keyboard.isDown(p.down) then
            p.locked = false
         elseif p.dl == 3 and not love.keyboard.isDown(p.left) then
            p.locked = false
         end
      end
   end

   return p
end