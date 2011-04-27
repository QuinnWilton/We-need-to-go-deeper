require "controller"
require "map"
MapController = class("MapController", Controller)

function MapController:initialize()
	Controller.initialize(self)
	self.map = Map:new(80,50)
end

function MapController:onInput(inputTable) -- Called before update!
	for k,v in pairs(inputTable) do
		if v.type == "keypress" then
			self.map:generateCellularAutomata(0.4, math.floor(math.random(1, 5)))
		end
	end
end

function MapController:onDraw()
	self.map:draw()
end