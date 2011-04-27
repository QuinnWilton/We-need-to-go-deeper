require "map"
require "state"

function love.load (args)
	title = love.graphics.getCaption()
	map = Map:new(80, 50)
end

function love.update (dt)
end

function love.draw ()
	love.graphics.setCaption(title .. " (fps " .. love.timer.getFPS() .. ")")
	map:draw()
end

function love.mousepressed (x, y, button)
end

function love.mousereleased (x, y, button)
end

function love.keypressed (key, unicode)
	map:generateCellularAutomata(0.4, math.floor(math.random(1, 5)))
end

function love.keyreleased (key)
end
