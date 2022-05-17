require 'animation'

cat = {}

function cat.load(x, y)
   cat.img1 = love.graphics.newImage("imgs/chillisSSs.png")
   cat.img2 = love.graphics.newImage("imgs/chillisSS.png")
   cat.anim = {}
   table.insert(cat.anim, newAnimation(cat.img1, 100, 100, 1))
   table.insert(cat.anim, newAnimation(cat.img2, 100, 100, 1))
   cat.currentAnim = 2

   cat.x, cat.y = x, y
end

function cat.update()
   cat.anim[cat.currentAnim].update()
end

function cat.draw()
   cat.anim[cat.currentAnim].draw(cat.x, cat.y)
end