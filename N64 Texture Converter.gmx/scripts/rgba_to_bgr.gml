var c = argument0;
var red, green, blue;

red = (c&$FF000000)>>16
green = (c&$00FF0000)
blue = (c&$0000FF00)<<16

return ((blue | green | red)>>8)
