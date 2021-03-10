var fname;

// Remove any popup that might exist
with obj_popup
    instance_destroy()

// Open a file
fname = get_open_filename("Image files (*.bmp;*.gif;*.jpg;*.png)", "")

// If we opened a file
if fname != ""
{
    // Delete the old sprite
    with (obj_sprite)
        instance_destroy()

    // Create a new one
    var obj;
    obj = instance_create(0,0,obj_sprite)    
    with (obj)
    {
        var spr;
        spr = sprite_add(fname, 0, false, false, 0, 0)
        
        // Ensure we managed to load an image
        if (!sprite_exists(spr))
        {
            scr_create_popup("Imported file is not a supported image format.", "Error", 320, 126, snd_criticalerror, 2)
            sprite_delete(spr)
            instance_destroy()
            exit
        }
        
        // Check the sprite isn't too wide
        if (sprite_get_width(spr) > 640)
        {
            scr_create_popup("Imported image is too wide. Maximum is 640 pixels.", "Error", 320, 126, snd_criticalerror, 2)
            sprite_delete(spr)
            instance_destroy()
            exit
        }
        
        // Check the sprite isn't too tall
        if (sprite_get_height(spr) > 480)
        {
            scr_create_popup("Imported image is too tall. Maximum is 480 pixels.", "Error", 320, 126, snd_criticalerror, 2)
            sprite_delete(spr)
            instance_destroy()
            exit
        }
        
        // Assign the sprite index
        sprite_index = spr

        // Set filenames
        global.filename = string_delete(filename_name(fname), string_length(filename_name(fname))-3, 4);
        global.filename = string_replace_all(global.filename, '#', '')
        global.arrayname = scr_fix_arrayname(global.filename)
        
        // Reset the view
        scr_zoom("Reset")
        view_wview[1] = obj_sprite.sprite_width
        view_hview[1] = obj_sprite.sprite_height
        view_wport[1] = obj_sprite.sprite_width
        view_hport[1] = obj_sprite.sprite_height
        
        // Allow us to see the sprite
        view_visible[1] = true
        
        scr_importsprite()
    }
}

// Clear the mouse state to prevent problems
mouse_clear(mb_any);
