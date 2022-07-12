require 'libs.utils'
require 'ball'
require 'winMargin'
require 'libs.trigonometry'
require 'scenes.golAnimation'

gameS = {}
gameS.isLoaded = false

function gameS:load()
   gameS.isLoaded = true
   love.graphics.setBackgroundColor(toRGB(100, 130, 180))
   team = 2

   balls = {}
   ballsLength = 10
   ballsStoped = 0
   ballSelected = 0
   for i = 1, ballsLength, 1 do
      table.insert(balls, newBall(i))
      balls[i]:setUD("ball"..i)
   end

   isGol = false

   players = {
      "Player1",
      "Player2",
      0, 0
   }

   for key in pairs(balls) do
      balls[key]:setCurrentTeam(team)
   end
   paredes:load(
      winW/2, winH/2,
      winW-300, winH-150,
      winH / 3
   )

   balon = newBalon()
   balon:load(paredes.p2.body:getX(), paredes.p3.body:getX())
   loadPositions()

   anim.gol:load()
end

function gameS:update(dt)
   if not self.isLoaded then
      self:load()
   end

   for key in pairs(balls) do
      if not isGol then
         balls[key]:update()
         balls[key]:updateLine()
      end
      balls[key]:particleUpdate(dt)
   end

   areBallsStoped()

   if not isGol then
      balon:update(dt)
   end

   mouseX, mouseY = love.mouse.getPosition()

   if isGol then
      anim.gol:update(dt)
   end
end

function gameS:draw()
   if self.isLoaded then

      paredes:draw()
      for key in pairs(balls) do
         balls[key]:drawParticles()
      end
      for key in pairs(balls) do
         balls[key]:draw()
      end
      balon:draw()
      for key in pairs(balls) do
         balls[key]:drawLine()
      end

      if isGol then
         anim.gol:draw()
      end
   end
end

function gameS:beginContact(a, b, coll)
   local data1, data2 = a:getUserData(), b:getUserData()
   local x, y = coll:getNormal()
   for key in pairs(balls) do
      balls[key].beginContact(data1, data2)
   end
   balon.beginContact(data1, data2, x)
end

function gameS:preSolve(a, b, coll)
   local data1, data2 = a:getUserData(), b:getUserData()
   local x, y = coll:getNormal()
   for key in pairs(balls) do
      balls[key].preSolve(data1, data2)
   end
   balon.beginContact(data1, data2, x)
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

function gol(s)
   isGol = true
   if s == 1 then
      players[3] = players[3] + 1
   elseif s == 2 then
      players[4] = players[4] + 1
   end

   anim.gol:load(s)
end

function loadPositions()
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
end

function setPositions()
   for key in pairs(balls) do
      balls[key].body:setLinearVelocity(0, 0)
   end
   balon.body:setLinearVelocity(0, 0)
   balls[1].body:setPosition(200, 200)
   balls[2].body:setPosition(400, 300)
   balls[3].body:setPosition(100, 500)
   balls[4].body:setPosition(300, 300)
   balls[5].body:setPosition(600, 100)
   balls[6].body:setPosition(650, 200)
   balls[7].body:setPosition(500, 300)
   balls[8].body:setPosition(500, 400)
   balls[9].body:setPosition(500, 500)
   balls[10].body:setPosition(500, 100)
   balon.body:setPosition(winW / 2, winH / 2)
end