require "lib/essential"
require "input"
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
