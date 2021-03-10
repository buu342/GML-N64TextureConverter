var fname;

// Remove any popup that might exist
with obj_popup
    instance_destroy()

// Open a file
fname = get_open_filename("Image files (*.bmp;*.gif;*.jpg;*.png)", "")

// If we opened a file
if fname != ""
{
    var spr;
    spr = sprite_add(fname, 0, false, false, 0, 0)
    
    // Ensure we managed to load an image
    if (!sprite_exists(spr))
    {
        scr_create_popup("Imported file is not a supported image format.", "Error", 320, 126, snd_criticalerror, 2)
        sprite_delete(spr)
        exit
    }
    
    // Check the sprite isn't too wide
    if (sprite_get_width(spr) != obj_sprite.sprite_width)
    {
        scr_create_popup("Alpha mask must be the same width as the imported image", "Error", 380, 126, snd_criticalerror, 2)
        sprite_delete(spr)
        exit
    }
    
    // Check the sprite isn't too tall
    if (sprite_get_height(spr) != obj_sprite.sprite_height)
    {
        scr_create_popup("Alpha mask must be the same height as the imported image.", "Error", 380, 126, snd_criticalerror, 2)
        sprite_delete(spr)
        exit
    }
        
    // Set the alpha mode
    global.usealpha = true
    global.alphatype = "AlphaMask"
    
    // Do the math
    obj_sprite.alpha = spr
    scr_importalpha()
}

// Clear the mouse state to prevent problems
mouse_clear(mb_any);
