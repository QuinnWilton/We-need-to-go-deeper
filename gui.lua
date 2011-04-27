require "lib/essential"

--GUIElement
--Base class for GUI objects

GUIElement = class("GUIElement")

function GUIElement:initialize(x, y, width, height)
	self.pos = {}
	self.size = {}
	self.childElements = {}
	self.hasFocus = false
	self.hasParent = false
	self.canGainFocus = true
	self.canLoseFocus = true
	self:setPos(x, y)
	self:setSize(width, height)
end

function GUIElement:giveFocus()
	if(!self.hasFocus and self.canGainFocus) then
		self:onGainedFocus()
		self.hasFocus = true
	end
end

function GUIElement:removeFocus()
	if(self.hasFocus and self.canLoseFocus) then
		self:onLostFocus()
		self.hasFocus = false
	end
end

function GUIElement:overlapsPoint(x, y) --used for press detection
	if x < self.pos.x then return false end
	if y < self.pos.y then return false end
	if x > self.pos.x+self.size.w then return false end
	if y > self.pos.y+self.size.h then return false end
	return true
end

function GUIElement:addChild(element)
	table.insert(self.childElements, element)
end

function GUIElement:getChildElements()
	return self.childElements
end

function GUIElement:setPos(x, y)
	self.pos.x = x
	self.pos.y = y
end

function GUIElement:getPos()
	return self.pos
end

function GUIElement:setSize(width, height)
	self.size.w = width
	self.size.h = height
end

function GUIElement:getSize()
	return self.size
end

function GUIElement:draw()
	self:onDraw()
	for k,e in pairs(self.childElements) do
		e:draw()
	end
end

function GUIElement:update()
	self:onUpdate()
	for k,e in pairs(self.childElements) do
		e:update()
	end
end

function GUIElement:remove()
	self:onRemove()
	for k,e in pairs(self.childElements) do
		e:remove()
	end
end


--EVENTS

function GUIElement:onDraw() --override this, not "draw()"

end

function GUIElement:onUpdate() --override this, not "update()"

end

function GUIElement:onGainedFocus() --implemented

end

function GUIElement:onLostFocus() --implemented

end

function GUIElement:onPress(button) --implemented

end

function GUIElement:onRelease(button) --implemented

end

function GUIElement:onMouseOver() --implemented

end

function GUIElement:onMouseOut() --implemented

end

--function GUIElement:onDrag()
--end

function GUIElement:onKeyPressed(key, unicode) --implemented

end

function GUIElement:onKeyReleased(key, unicode) --implemented

end

function GUIElement:onRemove() --implemented

end




--GUI
--Handles GUI Elements
GUI = class("GUI")

function GUI:initialize()
	self.elements = {}
	self.focusElement = nil
end

function GUI:draw() --we're drawing the topmost elements on the tree, they will call the draw methods of their child elements.
	if(self.focusElement != nil) then
		for k,e in pairs(self.elements) do
			if(e != self.focusElement) then
				if(!e.hasParent) then e:draw() end
			end
		end
			if(!self.focusElement.hasParent) then self.focusElement:draw() end --draw the element with focus on top
	else
		for k,e in pairs(self.elements) do
			if(!e.hasParent) then e:draw() end
		end
	end
end

function GUI:update() --we're updating the topmost elements on the tree, they will call the update methods of their child elements.
	local x, y = love.mouse.getPosition()
	for k,e in pairs(self.elements) do
		if(!e.hasParent) then e:update() end
		if(e:overlapsPoint(x, y)) then
			e:onMouseOver()
		else
			e:onMouseOut()
		end
	end
end

function GUI:handleMousePressed (x, y, button)
	if(self.focusElement != nil) then
		if(self.focusElement:overlapsPoint(x, y)) then
			self.focusElement:onPress(button)
			return
		else
			self.focusElement:removeFocus()
			self.focusElement = nil
		end
	end
	
	for k,e in pairs(self.elements) do
		if(e:overlapsPoint(x, y)) then
			e:onPress(button)
			if(self.focusElement == nil) then
				e:giveFocus()
			end
			return
		end
	end
end

function GUI:handleMouseReleased (x, y, button)
	if(self.focusElement != nil) then
		if(self.focusElement:overlapsPoint(x, y)) then
			self.focusElement:onRelease(button)
			return
		end
	end
	
	for k,e in pairs(self.elements) do
		if(e:overlapsPoint(x, y)) then
			e:onRelease(button)
			return
		end
	end
end

function GUI:handleKeyPressed (key, unicode)
	for k,e in pairs(self.elements) do
		e:onKeyPressed(key, unicode)
	end
end

function GUI:handleKeyReleased (key)
	for k,e in pairs(self.elements) do
		e:onKeyReleased(key, unicode)
	end
end

function GUI:addElement(class, parent, x,y, width, height)
	--TODO: make this work
end

