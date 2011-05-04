require "gui"

TestPanel = class("TestPanel", Panel)

--INIT/SETTINGS

function TestPanel:initialize(x, y, width, height)
	Panel.initialize(self, x, y, width, height)
	self.btn = GUI.addElement("Button", self, x+5, y+5, width-10, height-10)
	self.btn:setLabel("Regenerate")
end

--EVENTS


function GUI.factoryFuncs.TestPanel(x, y, width, height)
	return TestPanel:new(x, y, width, height)
end

GUI.registerGUI("TestPanel", GUI.factoryFuncs.TestPanel)


