require 'libs.utils'
require 'ball'
require 'winMargin'
require 'libs.trigonometry'

gameS = {}

function gameS:load()
   team = 2

   balls = {}
   ballsLength = 3
   ballsStoped = 0
   ballSelected = 0
   for i = 1, ballsLength, 1 do
      table.insert(balls, newBall(i))
      balls[i]:setUD("ball"..i)
   end

   balls[1]:load(200, 200, 50)
   balls[2]:load(400, 300, 50, 2)
   balls[3]:load(500, 100, 50, 2)

   ballon = newBalon()

   for key in pairs(balls) do
      balls[key]:setCurrentTeam(team)
   end
   paredes:load()
end

function gameS:update()
   for key in pairs(balls) do
      balls[key]:update()
   end

   areBallsStoped()

   mouseX, mouseY = love.mouse.getPosition()
end

function gameS:draw()
   for key in pairs(balls) do
      balls[key]:draw()
      balls[key]:drawLine()
   end
end

function gameS:beginContact(a, b)
   contactos(1, a, b)
   contactos(2, a, b)
   contactos(3, a, b)

   print(a:getUserData())
   print(b:getUserData())
end

function contactos(n, a, b)
   local i = n
   if a:getUserData() == "ball"..i and b:getUserData() == "wallUp" or
      a:getUserData() == "wallUp" and b:getUserData() == "ball"..i then
         balls[i].body:applyLinearImpulse(0, 40)
      elseif a:getUserData() == "ball"..i and b:getUserData() == "wallLeft" or
      a:getUserData() == "wallLeft" and b:getUserData() == "ball"..i then
         balls[i].body:applyLinearImpulse(40, 0)
      elseif a:getUserData() == "ball"..i and b:getUserData() == "wallDown" or
      a:getUserData() == "wallDown" and b:getUserData() == "ball"..i then
         balls[i].body:applyLinearImpulse(0, -40)
      elseif a:getUserData() == "ball"..i and b:getUserData() == "wallRight" or
      a:getUserData() == "wallRight" and b:getUserData() == "ball"..i then
         balls[i].body:applyLinearImpulse(-40, 0)
      end
end

function areBallsStoped()
   if balls[1].isStop and
      balls[2].isStop and
      balls[3].isStop then
         for i = 1, ballsLength, 1 do
            balls[i].ready = true
         end
      else
         for i = 1, ballsLength, 1 do
            balls[i].ready = false
         end
   end
end

function changeTeam(n)
   for key in pairs(balls) do
      balls[key]:setCurrentTeam(n)
   end
end

function lockBalls(s)
   for key in pairs(balls) do
      balls[key].locked = s
   end
end