require "gui"

Label = class("Label", GUIElement)

--INIT/SETTINGS

function Label:initialize(x, y, width, height)
	GUIElement.initialize(self, x, y, width, height)
	self.canGainFocus = true
	self.canLoseFocus = true
	self.text = "label"
	--self.font = nil
	self.color = {0, 0, 0}
end

function Label:setText(text)
	self.text = text
end

function Label:setColor(r, g, b)
	self.color = {r, g, b}
end

--EVENTS

function Label:onDraw()
	love.graphics.setColor(self.color[1], self.color[2], self.color[3])
	love.graphics.printf(self.text, self.pos.x, self.pos.y, self.size.w, "center")
	--love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h)
end

function Label:onUpdate()

end

function Label:onGainedFocus()

end

function Label:onLostFocus()

end

function Label:onPress(button)

end

function Label:onRelease(button)

end

function Label:onMouseOver()

end

function Label:onMouseOut()

end

function Label:onKeyPressed(key, unicode)

end

function Label:onKeyReleased(key, unicode)

end

function Label:onRemove()

end

function GUI.factoryFuncs.Label(x, y, width, height)
	return Label:new(x, y, width, height)
end

GUI.registerGUI("Label", GUI.factoryFuncs.Label)


