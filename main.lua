require "lib/essential"
require "state"
require "stack"
require "mapcontroller"

function curState()
	return mainStack:peek();
end

function love.load (args)
	curInput = {}
	title = love.graphics.getCaption()
	mainStack = Stack:new()
	mainState = State:new()
	mainController = MapController:new()
	
	mainState:addActor(mainController)
	mainStack:push(mainState)
end

function love.update (dt)
	curState():input(curInput)
	curState():update(dt)
	curInput = {}
end

function love.draw ()
	love.graphics.setCaption(title .. " (fps " .. love.timer.getFPS() .. ")")
	curState():draw()
end

function love.mousepressed (x, y, button)
end

function love.mousereleased (x, y, button)
end

function love.keypressed (key, unicode)
	table.insert(curInput, {t = "keypress", v = key})
end

function love.keyreleased (key)
	table.insert(curInput, {t = "keypress", v = key})
end
