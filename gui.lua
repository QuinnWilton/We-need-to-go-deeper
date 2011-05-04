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
	self.consumesMouseEvents = false
	self:setPos(x, y)
	self:setSize(width, height)
end

function GUIElement:giveFocus()
	if(not self.hasFocus and self.canGainFocus) then
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
		GUI.removeElement(e)--:remove()
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

GUIManager = class("GUIManager")

function GUIManager:initialize()
	self.elements = {}
	self.focusElement = nil
end

function GUIManager:draw() --we're drawing the topmost elements on the tree, they will call the draw methods of their child elements.
	if(self.focusElement ~= nil) then
		for k,e in pairs(self.elements) do
			if(e ~= self.focusElement) then
				if(not e.hasParent) then e:draw() end
			end
		end
			if(not self.focusElement.hasParent) then self.focusElement:draw() end --draw the element with focus on top
	else
		for k,e in pairs(self.elements) do
			if(not e.hasParent) then e:draw() end
		end
	end
end

function GUIManager:update(dt) --we're updating the topmost elements on the tree, they will call the update methods of their child elements.
	local x, y = love.mouse.getPosition()
	for k,e in pairs(self.elements) do
		if(not e.hasParent) then e:update() end
		if(e:overlapsPoint(x, y)) then
			e:onMouseOver()
		else
			e:onMouseOut()
		end
	end
end

function GUIManager:handleMousePressed (x, y, button)
	if(self.focusElement ~= nil) then
		if(self.focusElement:overlapsPoint(x, y)) then
			self.focusElement:onPress(button)
			return
		else
			self.focusElement:removeFocus()
			self.focusElement = nil
		end
	end
	
	for k,e in pairs(self.elements) do
		if(not e.hasParent) then
			self:sendMousePressed(e, x, y, button)
		end
		--if(e:overlapsPoint(x, y)) then
		--	e:onPress(button)
		--	if(self.focusElement == nil) then
		--		e:giveFocus()
		--	end
		--	return
		--end*/
	end
end

function GUIManager:sendMousePressed(e, x, y, button)
	if(#e.childElements < 1 or e.consumesMouseEvents) then
		if(e:overlapsPoint(x, y)) then
			e:onPress(button)
			if(self.focusElement == nil) then
				e:giveFocus()
			end
			return true
		end
	else
		for k,e2 in pairs(e.childElements) do
			if(self:sendMousePressed(e2, x, y, button)) then return true end
		end	
		return false
	end
end

function GUIManager:handleMouseReleased (x, y, button)
	if(self.focusElement ~= nil) then
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

function GUIManager:handleKeyPressed (key)--, unicode)
	for k,e in pairs(self.elements) do
		e:onKeyPressed(key, unicode)
	end
end

function GUIManager:handleKeyReleased (key)
	for k,e in pairs(self.elements) do
		e:onKeyReleased(key, unicode)
	end
end

function GUIManager:addElement(func, parent, x, y, width, height)
	local e = func(x, y, width, height)
	table.insert(self.elements, e)
	if(parent ~= nil) then
		e.hasParent = true
		parent:addChild(e)
	end
	return e
end

function GUIManager:removeElement(e)
	if(e == self.focusElement) then
		self.focusElement = nil
	end
	e:remove()
	table.remove(self.elements, e)
end

GUI = {}
GUI.factory = {}
GUI.factoryFuncs = {}

--function GUI.initialize()
--	GUI.activeInstance = GUIManager:new()
--end

function GUI.initialize()
	GUI.activeInstance = GUIManager:new()--nil
	return GUI.activeInstance.elements
end

function GUI.addElement(class, parent, x,y, width, height)
	--TODO: make this work
	return GUI.activeInstance:addElement(GUI.factory[class], parent, x,y, width, height)
end

function GUI.removeElement(e)
	GUI.activeInstance:removeElement(e)
end

function GUI.registerGUI(class, func)
	GUI.factory[class] = func
end

function GUI.update(dt)
	GUI.activeInstance:update(dt)
end

function GUI.draw()
	GUI.activeInstance:draw()
end

function GUI.handleMousePressed(x, y, button)
	GUI.activeInstance:handleMousePressed (x, y, button)
end

function GUI.handleMouseReleased(x, y, button)
	GUI.activeInstance:handleMouseReleased(x, y, button)
end

function GUI.handleKeyPressed(key)--, unicode)
	GUI.activeInstance:handleKeyPressed(key)--, unicode)
end

function GUI.handleKeyReleased(key)
	GUI.activeInstance:handleKeyReleased(key)
end

function GUI.swapElements(e)
	if(e ~= nil) then
		GUI.activeInstance.elements = e
	else
		GUI.activeInstance.elements = nil
		GUI.activeInstance.elements = {}
	end
end

