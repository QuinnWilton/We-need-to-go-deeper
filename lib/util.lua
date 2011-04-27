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