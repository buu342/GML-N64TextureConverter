// Argument0 - The X coordinate in the texel_tlut array
// Argument1 - The Y coordinate in the texel_tlut array
        
var texel1, texel2, nextx;

// Grab the first texel
if (global.basetlutnum != 0)
{
    texel1 = find_basetlut(argument0, argument1);
    if (texel1 == -1) return -1
}
else
    texel1 = obj_sprite.texel_tlut[argument0, argument1]
nextx = argument0+1

// Correct if the texel number was odd
if (argument0%2 != 0)
{
    if (global.basetlutnum != 0)
    {
        texel1 = find_basetlut(argument0-1, argument1);
        if (texel1 == -1) return -1
    }
    else
        texel1 = obj_sprite.texel_tlut[argument0-1, argument1]
    nextx = argument0
}
    
// Grab the second texel
if (nextx > obj_sprite.sprite_width-1)
    texel2 = 0
else
{
    if (global.basetlutnum != 0)
    {
        texel2 = find_basetlut(nextx, argument1);
        if (texel2 == -1) return -1
    }
    else
        texel2 = obj_sprite.texel_tlut[nextx, argument1]
}
    
// Return the calculated TLUT index
return ((texel1&$0F)<<4)|(texel2&$0F)

if (global.basetlutnum != 0)
{
    var t = find_basetlut(arrayx, arrayy);
    if (t != -1)
        tluttext = "0x"+dec_to_hex(t)
}
