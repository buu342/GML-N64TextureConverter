// Argument0 - 32Bit RGBA color
// Return - Grayscale pixel [0, 255]

var r = ((argument0>>24)&$FF)/255
var g = ((argument0>>16)&$FF)/255
var b = ((argument0>>8)&$FF)/255

return floor((0.2126*r + 0.7152*g + 0.0722*b)*255)
