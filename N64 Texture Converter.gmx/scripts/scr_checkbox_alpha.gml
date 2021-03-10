if argument0
    return global.usealpha
else
    global.usealpha = !global.usealpha
    
if (instance_exists(obj_sprite))
    scr_update_alpha()
