function love.load()
	math.randomseed(os.time())
	mouseX, mouseY = love.mouse:getPosition()
	local img = love.graphics.newImage('1.png')
	particles = {
		x = mouseX,
		y = mouseY
	}

	angle = 0

	psystem = love.graphics.newParticleSystem(img, 100)
	psystem:setEmissionArea("uniform", 5, 5, 0, true)
	psystem:setParticleLifetime(1, 1) -- Particles live at least 2s and at most 5s.
	psystem:setSpeed(100, 200)
	psystem:setEmissionRate(70)
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

	mouseP = false
end

function love.update(dt)
	color = {
		math.random(),
		math.random(),
		math.random()
	}
	if love.keyboard.isDown("escape") then love.event.quit() end
	psystem:update(dt)
	mouseX, mouseY = love.mouse:getPosition()
	--[[
	if love.mouse.isDown(1) and not mouseP then
		mouseP = true
		angle = angle + 0.785398
		psystem:setDirection(angle)
	elseif not love.mouse.isDown(1) and mouseP then
		mouseP = false
	end]]
	psystem:setPosition(mouseX, mouseY)
end

function love.draw()
	-- Draw the particle system at the center of the game window.
	love.graphics.setColor(color)
	love.graphics.draw(psystem)
end