require "gui"

Panel = class("Panel", GUIElement)

--INIT/SETTINGS

function Panel:initialize(x, y, width, height)
	GUIElement.initialize(self, x, y, width, height)
	self.canGainFocus = true
	self.canLoseFocus = true
end

--EVENTS

function Panel:onDraw()
	love.graphics.setColor(100, 150, 200)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h)
end

function Panel:onUpdate()

end

function Panel:onGainedFocus()

end

function Panel:onLostFocus()

end

function Panel:onPress(button)
	self.size.w = self.size.w+1
end

function Panel:onRelease(button)

end

function Panel:onMouseOver()

end

function Panel:onMouseOut()

end

function Panel:onKeyPressed(key, unicode)

end

function Panel:onKeyReleased(key, unicode)

end

function Panel:onRemove()

end

function GUI.factoryFuncs.Panel(x, y, width, height)
	return Panel:new(x, y, width, height)
end

GUI.registerGUI("Panel", GUI.factoryFuncs.Panel)


