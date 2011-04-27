Actor = class("Actor")

function Actor:initialize()
	self.id = 0 -- ID 0 will actually never be assigned in reality :)
	-- so if you get the id of an actor and it's 0? It's not 
	-- part of a state.
end

function Actor:onUpdate()
	-- We do nothing, just a prototype,
end

function Actor:onDraw()
	-- Same here.
end