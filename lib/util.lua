Rectangle = class("Rectangle")

function Rectangle:initialize(x, y, w, h)
	self.x1 = x
	self.y1 = y
	self.x2 = x + w
	self.y2 = y + h
	self.w = w
	self.h = h
end

function Rectangle:intersects(other)
	return (self.x1 <= other.x2 and self.x2 >= other.x1 and self.y1 <= other.y2 and self.y2 >= other.y1)
end

function Rectangle:center()
	return {math.floor((self.x1 + self.x2) / 2), math.floor((self.y1 + self.y2) / 2)}
end

Vector2d = class("Vector2d")

function Vector2d:initialize(x, y)
	self.x = x
	self.y = y
end

function Vector2d:add(other)
	return Vector2d:new(self.x + other.x, self.y + other.y)
end

function Vector2d:scale(scalar)
	return Vector2d:new(self.x*scalar, self.y*scalar)
end

function Vector2d:length()
	return math.sqrt(self.x*self.x + self.y*self.y)
end

--Return the sum of the squared components.  Faster than length since it ignores the square root
function Vector2d:length2()
	return self.x*self.x + self.y*self.y
end

function Vector2d:normalize()
	local length = self:length()
	if length == 0 then return self
	else return self:scale(1/length) end
end