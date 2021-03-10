if (instance_exists(obj_sprite))
    scr_create_popup_yesno("This will overwrite your image's alpha mask. Continue?", "Warning", 360, 126, snd_exclamation, 1, scr_import_alpha_file)
else
    scr_create_popup("You must import an image first.", "Error", 256, 126, snd_criticalerror, 2)
