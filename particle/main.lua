function love.load()
	local img = love.graphics.newImage('logo.png')
	particles = {
		x = love.graphics.getWidth() / 2,
		y = love.graphics.getHeight() / 2
	}

	psystem = love.graphics.newParticleSystem(img, 32)
	psystem:setEmissionArea("uniform", 10, 10, 0, false)
	psystem:setParticleLifetime(1, 1) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(10)
	psystem:setSpeed(100, 300)
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
end

function love.draw()
	-- Draw the particle system at the center of the game window.
	love.graphics.draw(psystem, particles.x, particles.y)
end

function love.update(dt)
	psystem:update(dt)
	--particles.y = particles.y + 1
end