var red, green, blue, alpha;
red   = argument0
green = argument1
blue  = argument2
alpha = argument3

return ((red&$FF)<<24) | ((green&$FF)<<16) | ((blue&$FF)<<8) | ((alpha&$FF))
