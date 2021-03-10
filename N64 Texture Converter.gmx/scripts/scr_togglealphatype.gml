// argument0 - Value to compare/set
// argument1 - 1 for check, 0 for set
// argument2 - Skip first check

if !global.usealpha && !argument2
    return -1
if argument1
    return argument0 == global.alphatype
else
    global.alphatype = argument0
    
if (instance_exists(obj_sprite))
{
    scr_update_alpha()
    if (scr_generate_tlut(1) == 0 && obj_sprite.sprite_tlut[0] != -1)
        scr_generate_tlut(0, 1)    
}
