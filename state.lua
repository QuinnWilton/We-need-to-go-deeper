State = class("State")

function State:initialize()
	self.actors = {}
	self.controllers = {}
end

function State:recieveInput(inputTable)
-- TODO: STUB SON!
-- Instead of the event based input love uses
-- this will collect all of that into a table
-- and pass it to controllers to loop through.
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
	actor:kill()
	self.actors[actor.id] = nil;
	self.actors[actor.cid] = nil;
end

function State:Update()
	for k,v in pairs(self.actors) do
		v:onUpdate()
	end
end

function State:Draw()
	for k,v in pairs(self.actors) do
		v:onDraw()
	end
end
