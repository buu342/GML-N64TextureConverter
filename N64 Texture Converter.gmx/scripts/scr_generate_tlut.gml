// Argument0 - Get if generate palette is valid (used to activate/deactivate Generate Palette button)
// Argument1 - Silent mode
var silent = 0;

if (argument_count > 0 && argument[0] == 1)
{
    if (!instance_exists(obj_sprite))
        return -1
    else 
    {
        switch(global.exporttype)
        {
            case ("8B-CI"):
            case ("4B-CI"):
                return 0
            default:
                return -1
        }
    }
}

var ncol = 0
var maxcol = 256
var hashmap = ds_map_create()
var i, j, w, h;

// Get if silent mode
if (argument_count == 2)
    silent = argument[1]

// Ensure an image has been imported first
if (!instance_exists(obj_sprite) && !silent)
{
    scr_create_popup("You must import a sprite first.", "Error", 256, 126, snd_criticalerror, 2)
    exit
}

// Ensure a mode that supports palettes is selected
if (global.exporttype != "8B-CI" && global.exporttype != "4B-CI" && !silent)
{
    scr_create_popup("This image mode does not support palettes.", "Error", 300, 126, snd_criticalerror, 2)
    exit
}

// Set the max colors if on 4Bit mode
if (global.exporttype == "4B-CI")
    maxcol = 16

// Get image dimensions
w = obj_sprite.sprite_width
h = obj_sprite.sprite_height

// Iterate through all pixels
for (j=0; j<h; j+=1)
{
    for (i=0; i<w; i+=1)
    {
        var col = ((obj_sprite.sprite_color[i, j]&($FFFFFF00)) | (obj_sprite.sprite_alpha[i, j]&$FF))
        if (!ds_map_exists(hashmap, col))
        {
            if (ncol+1 > maxcol)
            {
                if (!silent)
                    scr_create_popup("Your image has too many colors (maximum of "+string(maxcol)+" colors).", "Error", 370, 126, snd_criticalerror, 2)
                scr_clear_tlut();
                exit
            }
        
            // Set the data
            obj_sprite.sprite_tlut[ncol] = col;
            ds_map_add(hashmap, col, ncol)
            ncol +=1
        }
        obj_sprite.texel_tlut[i, j] = ds_map_find_value(hashmap, col);
    }
}
if (!silent)
    scr_create_popup("Palette generated successfully.", "Success", 256, 126, snd_ding, 0)

// Free memory used by the hashmap
ds_map_destroy(hashmap)
obj_sprite.ntlut = ncol
