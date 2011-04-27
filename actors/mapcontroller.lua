require "controller"
require "map"
MapController = class("MapController", Controller)

function MapController:initialize()
	Controller.initialize(self)
	self.map = Map:new(80,50)
end

function MapController:onInput(inputTable) -- Called before update!
	for k,v in pairs(inputTable) do
		if v.t == "keypress" then
			self.map:generateCellularAutomata(0.4, math.floor(math.random(1, 5)))
			-- In reality you shouldn't really be doing anything time/state
			-- dependent in this function, this is PURELY for handling input.
			-- So handle input here, say decide what direction your character is
			-- going to move this frame and THEN do that in onUpdate, not here.
		end
	end
end

function MapController:onDraw()
	self.map:draw()
end