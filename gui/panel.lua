require "gui"

Panel = class("Panel", "GUIElement")

--INIT/SETTINGS

function GUIElement:initialize(x, y, width, height)
	GUIElement.initialize(self, x, y, width, height)
	self.canGainFocus = true
	self.canLoseFocus = true
end

--EVENTS

function GUIElement:onDraw()
	love.graphics.setColor(100, 150, 200)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h)
end

function GUIElement:onUpdate()

end

function GUIElement:onGainedFocus()

end

function GUIElement:onLostFocus()

end

function GUIElement:onPress(button)
	self.size.w = self.size.w+1
end

function GUIElement:onRelease(button)

end

function GUIElement:onMouseOver()

end

function GUIElement:onMouseOut()

end

function GUIElement:onKeyPressed(key, unicode)

end

function GUIElement:onKeyReleased(key, unicode)

end

function GUIElement:onRemove()

end
