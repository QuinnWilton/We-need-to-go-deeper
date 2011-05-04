require "state"
require "map"
MapState = class("MapState", State)

function MapState:initialize(data)
	State.initialize(self)
	self.center = Vector2d:new(0,0)
	if data then
		self.map = data.map
		self.actors = data.actors
		self.controllers = data.controllers
	else
		self.map = Map:new(50,50)
	end
end

function MapState:update(dt)
	State.update(self)
end

function MapState:draw(dt)
	self.map:draw(self.center, Vector2d:new(10,7.5))
	State.draw(self)
end

function MapState:regenerate() --for testing
	self.map = Map:new(50,50)
	self.center = Vector2d:new(0,0)
	print("Map randomized.")
end

function MapState:setOffset(vec)
	self.center = vec
end