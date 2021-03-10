var i, j, k;

if (instance_number(obj_sprite) == 0)
    return -1;

for (k=0; k<global.basetlutnum; k++)
    if (global.basetlut[k] == obj_sprite.sprite_color[argument0, argument1]&$FFFFFF00 | obj_sprite.sprite_alpha[argument0, argument1])
        return k;

return -1
