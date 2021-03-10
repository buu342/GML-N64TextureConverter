if (instance_exists(obj_sprite))
    scr_create_popup_yesno("This will overwrite your image. Continue?", "Warning", 320, 126, snd_exclamation, 1, scr_import_sprite_file)
else
    scr_import_sprite_file()
