function love.mousepressed (x, y, button)
	vec = Vector2d:new(x,y)
	table.insert(curInput, {t = "mousedown", v = vec  })
end

function love.mousereleased (tx, ty, button)
	vec = Vector2d:new(x,y)
	table.insert(curInput, {t = "mouseup", v = vec })
end

function love.keypressed (key, unicode)
	table.insert(curInput, {t = "keypress", v = key})
end

function love.keyreleased (key)
	table.insert(curInput, {t = "keyup", v = key})
end
