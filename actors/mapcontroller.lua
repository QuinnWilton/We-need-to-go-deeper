require "controller"
require "map"
MapController = class("MapController", Controller)

function MapController:initialize()
	Controller.initialize(self)
	self.map = Map:new(80,80)
	self.isZooming = 1
	self.minTiles = 10
	self.maxTiles = 80
	self.timeToZoom = 10
	self.zoom = 0
end

function MapController:onInput(inputTable) -- Called before update!
	for k,v in pairs(inputTable) do
		if v.t == "keypress" then
			self.map:generateCellularAutomata(0.4, math.floor(math.random(1, 5)))
			-- In reality you shouldn't really be doing anything time/state
			-- dependent in this function, this is PURELY for handling input.
			-- So handle input here, say decide what direction your character is
			-- going to move this frame and THEN do that in onUpdate, not here.
			self.zoom = 0
			self.isZooming = 1 
		end
	end
end

function MapController:onUpdate(dt)
	self.zoom = self.zoom + (dt*self.isZooming)
	if self.zoom > self.timeToZoom then
		self.isZooming = -1
		self.zoom = self.timeToZoom
	elseif self.zoom < 0 then
		self.isZooming = 1
		self.zoom = 0
	end
end

function MapController:onDraw()
	temp = self.zoom*((self.maxTiles-self.minTiles)/self.timeToZoom)+10
	self.map:draw(Vector2d:new(0,0), Vector2d:new(temp,temp))
end