var fname;

// Remove the sprite object if it exists
if (instance_exists(obj_sprite))
    scr_create_popup_yesno("Unsaved changes will be lost. Continue?", "Warning", 300, 126, snd_exclamation, 1, scr_restart)
else
    scr_restart()
