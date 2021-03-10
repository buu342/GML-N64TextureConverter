// Argument0 - The X coordinate in the sprite_color array
// Argument1 - The Y coordinate in the sprite_color array
        
var texel1, texel2, nextx;

// Grab the first texel
texel1 = bitcrunch(rgb_to_gray(obj_sprite.sprite_color[argument0, argument1]), 4)
nextx = argument0+1
if (argument0%2 != 0)
{
    texel1 = bitcrunch(rgb_to_gray(obj_sprite.sprite_color[argument0-1, argument1]), 4)
    nextx = argument0
}
    
// Grab the second texel
if (nextx > obj_sprite.sprite_width-1)
    texel2 = 0
else
    texel2 = bitcrunch(rgb_to_gray(obj_sprite.sprite_color[nextx, argument1]), 4)

// Return the calculated TLUT index
return ((texel1&$0F)<<4)|(texel2&$0F)
