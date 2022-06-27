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
   for key in pairs(balls) do
      balls[key]:collision(a, b)
   end
   print(a:getUserData())
   print(b:getUserData())
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