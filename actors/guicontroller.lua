require "controller"
require "gui"
require "gui/classes"

GUIController = class("GUIController", Controller)

function GUIController:initialize()
	Controller.initialize(self)
	self.curPos = Vector2d:new(0,0)
	self.elements = GUI.initialize()
end

function GUIController:onInput(inputTable) -- Called before update! 
	for k,v in pairs(inputTable) do
		if(v.t == "keypress") then
			GUI.handleKeyPressed(v.v)
		elseif(v.t == "keyup") then
			GUI.handleKeyReleased(v.v)
		elseif(v.t == "mousedown") then
			GUI.handleMousePressed(v.v.pos.x, v.v.pos.y, v.v.btn)
		elseif(v.t == "mouseup") then
			GUI.handleMouseReleased(v.v.pos.x, v.v.pos.y, v.v.btn)
		end
	end
end

function GUIController:onUpdate(dt)
	GUI.update(dt)
end

function GUIController:onDraw()
	GUI.draw()
end

function GUIController:onRemove()
	GUI.swapElements(nil)
end
