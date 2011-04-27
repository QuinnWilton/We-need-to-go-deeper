State = class("State")

function State:initialize()
	self.actors = {}
	self.controllers = {}
end

function State:input(inputTable)
	for k,v in pairs(self.controllers) do
		v:onInput(inputTable)
	end
end

function State:addActor(actor)
	actor.id = #self.actors + 1
	if actor.isController then
		actor.cid = #self.controllers + 1
		table.insert(self.controllers, actor)
	end
	table.insert(self.actors, actor)
	return #self.actors
end

function State:removeActor(actor)
	self.actors[actor.id].id, self.actors[actor.id].cid = 0
	self.actors[actor.id] = nil;
	self.actors[actor.cid] = nil;
end

function State:update(dt)
	for k,v in pairs(self.actors) do
		v:onUpdate()
	end
end

function State:draw()
	for k,v in pairs(self.actors) do
		v:onDraw()
	end
end
