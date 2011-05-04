require "gui"

Button = class("Button", Panel)

--INIT/SETTINGS

function Button:initialize(x, y, width, height)
	GUIElement.initialize(self, x, y, width, height)
	self.canGainFocus = true
	self.canLoseFocus = true
	self.consumesMouseEvents = true
	self.targetFunc = nil
	self.overColor = {200, 200, 200}
	self.outColor = {150, 150, 150}
	self.color = self.outColor
	self.label = GUI.addElement("Label", self, x+2, y+height/4, width, height)
	--self.label:setText("button")
end

function Button:setTargetFunc(func)
	self.targetFunc = func
end

function Button:setLabel(text)
	self.label:setText(text)
end

function Button:setOverColor(r, g, b)
	self.overColor = {r, g, b}
end

function Button:setOutColor(r, g, b)
	self.outColor = {r, g, b}
end

--EVENTS

function Button:onDraw()
	love.graphics.setColor(self.color[1], self.color[2], self.color[3])--100, 150, 200)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h)
end

function Button:onUpdate()

end

function Button:onGainedFocus()

end

function Button:onLostFocus()

end

function Button:onPress(button)
	--self.size.w = self.size.w+1
	--print("test " .. self.targetFunc)
	if(self.targetFunc ~= nil) then
		self.targetFunc()
	end
end

function Button:onRelease(button)

end

function Button:onMouseOver()
	self.color = self.overColor
end

function Button:onMouseOut()
	self.color = self.outColor
end

function Button:onKeyPressed(key, unicode)

end

function Button:onKeyReleased(key, unicode)

end

function Panel:onRemove()

end

function GUI.factoryFuncs.Button(x, y, width, height)
	return Button:new(x, y, width, height)
end

GUI.registerGUI("Button", GUI.factoryFuncs.Button)


