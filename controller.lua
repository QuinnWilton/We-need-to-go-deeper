require "actor"
Controller = class("Controller", Actor)

function Controller:initialize()
	Actor.initialize(self)
	self.cid = 0
	self.isController = true
end

function Controller:onInput(inputTable)
	--Just a stub kept here to clarify what
	--the input recieving function should
	--look like
end