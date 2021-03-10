// Argument0 - h
// Argument1 - s
// Argument2 - l

var h = argument0
var s = argument1/255
var l = argument2/255
var v = l+s*min(l, 1-l)

if (l = 0)
    s = 0
else
    s = 2*(1-l/v)
return s*255
