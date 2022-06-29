require 'libs.utils'
require 'ball'
require 'winMargin'
require 'libs.trigonometry'

gameS = {}

function gameS:load()
   team = 2

   balls = {}
   ballsLength = 10
   ballsStoped = 0
   ballSelected = 0
   for i = 1, ballsLength, 1 do
      table.insert(balls, newBall(i))
      balls[i]:setUD("ball"..i)
   end

   balls[1]:load(200, 200, 50)
   balls[2]:load(400, 300, 50)
   balls[3]:load(100, 500, 50)
   balls[4]:load(500, 100, 50)
   balls[5]:load(300, 300, 50)
   balls[6]:load(600, 100, 50, 2)
   balls[7]:load(650, 200, 50, 2)
   balls[8]:load(500, 300, 50, 2)
   balls[9]:load(500, 400, 50, 2)
   balls[10]:load(500, 500, 50, 2)

   balon = newBalon()
   balon:load()

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

   balon:update()

   mouseX, mouseY = love.mouse.getPosition()
end

function gameS:draw()
   for key in pairs(balls) do
      balls[key]:draw()
      balls[key]:drawLine()
   end
   balon:draw()
end

function gameS:beginContact(a, b)
   local data1, data2 = a:getUserData(), b:getUserData()
   for key in pairs(balls) do
      balls[key].beginContact(data1, data2)
   end
   balon.beginContact(data1, data2)
end

function gameS:preSolve(a, b)
   local data1, data2 = a:getUserData(), b:getUserData()
   for key in pairs(balls) do
      balls[key].preSolve(data1, data2)
   end
   balon.beginContact(data1, data2)
end

function areBallsStoped()
   if balls[1].isStop and
      balls[2].isStop and
      balls[3].isStop and
      balls[4].isStop and
      balls[5].isStop and
      balls[6].isStop and
      balls[7].isStop and
      balls[8].isStop and
      balls[9].isStop and
      balls[10].isStop then
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