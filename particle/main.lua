function love.load()
	local img = love.graphics.newImage('1.png')
	particles = {
		x = love.graphics.getWidth() / 2,
		y = love.graphics.getHeight() / 2
	}

	angle = 0

	psystem = love.graphics.newParticleSystem(img, 100)
	psystem:setEmissionArea("uniform", 10, 10, angle, false)
	psystem:setParticleLifetime(1, 1) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(50)
	psystem:setSpeed(100, 300)
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

	mouseP = false
end

function love.update(dt)
	psystem:update(dt)
	if love.mouse.isDown(1) and not mouseP then
		mouseP = true
		angle = angle + 0.785398
		psystem:setDirection(angle)
	elseif not love.mouse.isDown(1) and mouseP then
		mouseP = false
	end
end

function love.draw()
	-- Draw the particle system at the center of the game window.
	love.graphics.draw(psystem, particles.x, particles.y)
end