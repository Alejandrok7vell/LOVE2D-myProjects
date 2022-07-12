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
   team = 1

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

   board = {
      x = winW/2, y = winH/2 + 50,
      w = winW-180, h = winH-175,
      z = winH/3, cw = 65
   }
   positions = require("positions")

   paredes:load(board.x, board.y, board.w, board.h, board.z, board.cw)

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
   local r = 40
   local p = positions
   balls[1]:load(p.p1[1][1].x, p.p1[1][1].y, r)
   balls[2]:load(p.p1[1][2].x, p.p1[1][2].y, r)
   balls[3]:load(p.p1[1][3].x, p.p1[1][3].y, r)
   balls[4]:load(p.p1[1][4].x, p.p1[1][4].y, r)
   balls[5]:load(p.p1[1][5].x, p.p1[1][5].y, r)
   balls[6]:load(p.p2[1][1].x, p.p2[1][1].y, r, 2)
   balls[7]:load(p.p2[1][2].x, p.p2[1][2].y, r, 2)
   balls[8]:load(p.p2[1][3].x, p.p2[1][3].y, r, 2)
   balls[9]:load(p.p2[1][4].x, p.p2[1][4].y, r, 2)
   balls[10]:load(p.p2[1][5].x, p.p2[1][5].y, r, 2)
end

function setPositions()
   balon.body:setLinearVelocity(0, 0)
   for key in pairs(balls) do
      balls[key].body:setLinearVelocity(0, 0)
   end
   local p = positions
   balls[1].body:setPosition(p.p1[1][1].x, p.p1[1][1].y)
   balls[2].body:setPosition(p.p1[1][2].x, p.p1[1][2].y)
   balls[3].body:setPosition(p.p1[1][3].x, p.p1[1][3].y)
   balls[4].body:setPosition(p.p1[1][4].x, p.p1[1][4].y)
   balls[5].body:setPosition(p.p1[1][5].x, p.p1[1][5].y)
   balls[6].body:setPosition(p.p2[1][1].x, p.p2[1][1].y)
   balls[7].body:setPosition(p.p2[1][2].x, p.p2[1][2].y)
   balls[8].body:setPosition(p.p2[1][3].x, p.p2[1][3].y)
   balls[9].body:setPosition(p.p2[1][4].x, p.p2[1][4].y)
   balls[10].body:setPosition(p.p2[1][5].x, p.p2[1][5].y)
   balon.body:setPosition(board.x, board.y)
end