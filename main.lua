require "lib/essential"
require "input"
require "state"
require "stack"
require "actors/mapcontroller"
require "gui"
require "gui/panel"

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
	
	--GUI usage example
	local panel = GUI.addElement("Panel", nil, 50, 50, 100, 100)
	panel:setSize(200, 200)
	
end

function love.update (dt)
	curState():input(curInput)
	curState():update(dt)
	curInput = {}
	GUI.update(dt)
	--TODO: move the GUI update/draw functions where necessary
	--also, call the GUI input handling functions (see gui.lua)
end

function love.draw ()
	love.graphics.setCaption(title .. " (fps " .. love.timer.getFPS() .. ")")
	curState():draw()
	GUI.draw()
end
