require "lib/essential"
require "input"
require "stack"
require "actors/mapcontroller"
require "states/mapstate"
require "actors/guicontroller"
--require "gui"
--require "gui/panel"

function curState()
	return mainStack:peek();
end

function love.load (args)
	curInput = {}
	title = love.graphics.getCaption()
	mainStack = Stack:new()
	mainState = MapState:new()
	mainController = MapController:new()
	guiController = GUIController:new()
	
	mainState:addActor(mainController)
	mainState:addActor(guiController)
	mainStack:push(mainState)
	
	--GUI usage example 
	local panel = GUI.addElement("TestPanel", nil, 680, 10, 100, 34)
	panel.btn:setOverColor(0, 200, 255)
	panel.btn:setOutColor(0, 190, 220)
	panel.btn:setTargetFunc(testFunc) --mainState.regenerate
	--panel:setSize(200, 200)
	
end

function testFunc() --example Button target function
	--print("button pressed!")
	mainState:regenerate()
	mainController.curPos = Vector2d:new(0,0)
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
