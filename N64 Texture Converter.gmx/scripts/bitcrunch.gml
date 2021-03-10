// Argument0 - The number to crunch
// Argument1 - The number of bits to crunch it to
// Returns - The bitcrunched version of the number
var p = power(2, argument1)-1
var r = p/255
return round(argument0*r)&p;
