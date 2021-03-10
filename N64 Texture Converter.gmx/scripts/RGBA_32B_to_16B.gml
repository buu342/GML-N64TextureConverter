var col = argument0
var r, g, b, a;

r = bitcrunch((col>>24)&$FF, 5)&$1F;
g = bitcrunch((col>>16)&$FF, 5)&$1F;
b = bitcrunch((col>>8)&$FF, 5)&$1F;
a = bitcrunch((col)&$FF, 1)&$1;

return (r << 11) | (g << 6) | (b << 1) | (a)
