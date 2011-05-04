require "controller"
require "map"
MapController = class("MapController", Controller)

function MapController:initialize()
	Controller.initialize(self)
	self.shouldMove = false
	self.curPos = Vector2d:new(0,0)
end

function MapController:onInput(inputTable) -- Called before update!
	for k,v in pairs(inputTable) do
		if v.t == "keypress" then
			if v.v == "w" or v.v == "s" or v.v == "a" or v.v == "d" then
				self.shouldMove = v.v
			end
		end
	end
end

function MapController:onUpdate(dt)
	if self.shouldMove then --this method is full of terrible
		m = self.shouldMove -- just a shortcut
		if m == "w" then self.curPos.y = self.curPos.y + 1 end
		if m == "s" then self.curPos.y = self.curPos.y - 1 end
		if m == "a" then self.curPos.x = self.curPos.x + 1 end
		if m == "d" then self.curPos.x = self.curPos.x - 1 end
		curState():setOffset(self.curPos)
	end
	self.shouldMove = false
end

function MapController:onDraw()
-- WE DON'T DRAW NOTHING SIR.
end