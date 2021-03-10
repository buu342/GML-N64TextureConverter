if (!instance_exists(obj_sprite))
    scr_create_popup("You must import a sprite first.", "Error", 256, 126, snd_criticalerror, 2)
else
    obj_sprite.draw_alpha = !obj_sprite.draw_alpha
